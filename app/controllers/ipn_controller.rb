class IpnController < ApplicationController
  def index

    data = request.body.read

    puts data

    response = Hash.from_xml(data)

    puts response

    r = response["InstantPaymentNotification"]
    msisdn = r["MSISDN"]
    business_short_code = r["BusinessShortCode"]
    invoice_number = r["InvoiceNumber"]
    trans_id = r["TransID"]
    trans_amount = r["TransAmount"]
    third_party_trans_id = r["ThirdPartyTransID"]
    trans_time = r["TransTime"]
    bill_ref_no = r["BillRefNumber"]

    @ipn = Ipn.create(MSISDN: msisdn, BusinessShortCode: business_short_code, InvoiceNumber: invoice_number, TransID: trans_id, TransAmount: trans_amount, ThirdPartyTransID: third_party_trans_id, TransTime: trans_time, bill_ref_no: bill_ref_no)
    if @ipn
      render :json => {'status': 'ok'}
      check_order(bill_ref_no, trans_amount, trans_id)
    end
  end

  def check_order(ref, amount, transid)

    # BROKEN DOWN INCASE I NEED TO ADD MORE STUFF DEPENDING ON THE ORDER STATUS

    @order = Order.where(ref: ref).first

    if @order.nil?
      @order = Subscription.where(ref: ref, order_status_id: 5).first
      if @order.nil?
        Unresolved.create(transid: transid)
      else
        newamount = @order.received.to_i + amount.to_i
        transactions = @order.number_of_transactions + 1
        @order.update(number_of_transactions: transactions, received: newamount)
        complete_sub(@order, amount)
      end
    elsif @order.order_status_id == 5
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions: transactions, amount_received: newamount)
      complete(@order, amount)
    elsif @order.order_status_id == 2
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions: transactions, amount_received: newamount)
      complete(@order, amount)
    elsif @order.order_status_id == 1
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions: transactions, amount_received: newamount, date_placed: Time.now, date_placed2: Time.now.strftime("%Y-%m-%-d"))
      complete(@order, amount)
    end

  end

  def complete(ref, amount)
    @order = ref
    store_amount(ref, amount)
    if @order.total.to_i <= @order.amount_received.to_i
      @order.update(order_status_id: 2)
      update_inventory(@order)
      PaymentsMailer.full_payment_recieved(@order).deliver
      PaymentsMailer.merchant_payment_recieved(@order).deliver
      SmsController::client_sms(@order,1)
      SmsController::merchant_sms(@order,1)
    else
      @order.update(order_status_id: 5)
      PaymentsMailer.partial_payment_recieved(@order).deliver
      PaymentsMailer.partial_merchant_payment_recieved(@order).deliver
      SmsController::client_sms(@order,0)
      SmsController::merchant_sms(@order,0)
    end
  end

  def complete_sub(ref, amount)
    require 'active_support'
    @order = ref
    if amount.to_i >= @order.amount.to_i

      @order.update(order_status_id: 6)
      @store = Store.find(ref.store_id)

      now = Time.now

      puts "ORDER DESC IS #{@order.description}"

      if @store.premiumexpiry.nil?
        puts "expiry is nil, adding one month to now"

        expire = now + 1.month
        @plan_id = ""
        if @order.description == 'basic'
          description = 'the basic plan'
          @plan_id = 1
        elsif @order.description == 'premium'
          description = 'the premium plan'
          @plan_id = 2
        end

      else
        puts "expiry not yet reached, adding one month to #{@store.premiumexpiry}"

        puts "total days is #{total_days(@store.premiumexpiry)} , expiry is #{@store.premiumexpiry} and new should be #{@store.premiumexpiry + 1.month}"

        if total_days(@store.premiumexpiry) > 0

          expire = @store.premiumexpiry + 1.month
          @store.update(premiumexpiry:expire)
        end

      end

      r = SubscriptionRecord.create(store_id: @order.store_id, start: now, expire: expire, subscription_id: @order.id, description: description)

      if @plan_id == 1
        puts "Plan id is #{@plan_id} proceeding"
        reconnect(Store.find(@order.store_id), @plan_id, expire)
      elsif @plan_id == 2
        puts "Plan id is #{@plan_id} proceeding"
        reconnect_premium(Store.find(@order.store_id), @plan_id, expire)
      else
        puts "Plan id is missing proceeding"
      end
      inv = Invoice.where(uid: ref.ref).first

      inv.update(order_status_id: 6)

      PaymentsMailer.full_subscription_payment_recieved(@order, r).deliver
      SmsController::confirm_sub(@order)


    else
      @order.update(order_status_id: 5)

      SmsController::partial_sub(@order)

    end
  end

  def update_inventory(o)
    o.order_items.all.each do |oi|
      @product = Product.find(oi.product_id)
      if !@product.nil?
        nu = @product.quantity - oi.quantity
        sold = @product.number_sold += 1
        @product.update(quantity: nu, number_sold: sold)
      end
    end
  end

  def b2c
    puts request.body.read
    response = JSON.parse(request.body.read)
    @params = Hash.[]
    response.each do |(k, a)|
      if k == "Id"
        @params["Trans_#{k}"] = a
      elsif k == "OrderLines"
        response["OrderLines"][0].each do |(c, b)|
          if c == "Type" or c == "TypeDesc"
            @params["o_#{c}"] = b
          else
            @params["#{c}"] = b
          end
          if c == "Reference"
            @ref = b
          end
        end
      else
        @params["#{k}"] = a
      end
    end
    BusinessToConsumer.create(@params)
    @transaction = Transaction.where(ref: @ref)
    @transaction.update(transaction_status_id: 2)
    render :json => @params

  end

  def store_amount(order, amount)
    @store_amount = StoreAmount.where(store_id: order.store_id).first
    if @store_amount.nil?
      StoreAmount.create(amount: 0, actual: 0, store_id: order.store_id)
      @store_amount = StoreAmount.where(store_id: order.store_id).first
    end
    if @store_amount.actual.nil?
      @store_amount.update(actual: 0)
    end
    nu = @store_amount.actual + amount.to_i
    if @store_amount.lifetime_earnings.nil?
      @store_amount.update(lifetime_earnings: 0)
    end
    le = @store_amount.lifetime_earnings.to_i + amount.to_i
    @store_amount.update(actual: nu, lifetime_earnings: le)
  end

  def ipay
    puts request.body.read
    response = JSON.parse(request.body.read)
    @params = Hash.[]
    response.each do |(k, a)|
      if k == "id"
        @params["trans_#{k}"] = a
      else
        @params["#{k}"] = a
      end
    end
    @ipn = Iipn.create(@params)

    if @ipn
      render :json => {'status':'ok'}
      check_order(@params['trans_id'], @params['mc'], @params['txncd'])
    end
  end

  def process_ipn
    require 'json'
    #puts response.read_body
    pars = request.GET
    #pars2 = JSON.parse(pars)
    Iipn.create(pars.merge(id: nil))

    val = "#{ENV['ipay_vid']}";

    val1 = pars["id"];
    val2 = pars["ivm"];
    val3 = pars["qwh"];
    val4 = pars["afd"];
    val5 = pars["poi"];
    val6 = pars["uyt"];
    val7 = pars["ifd"];

    ipnurl = "https://www.ipayafrica.com/ipn/?vendor=#{val}&id=#{val1}&ivm=#{val2}&qwh=#{val3}&afd=#{val4}&poi=#{val5}&uyt=#{val6}&ifd=#{val7}"

    require 'net/http'

    uri = URI.parse(ipnurl)

    # Shortcut
    #response = Net::HTTP.post_form(uri, {"user[name]" => "testusername", "user[email]" => "testemail@yahoo.com"})

    # Full control
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    valcode = response.body

    if valcode == 'aei7p7yrx4ae34'
      #render :json => {'status': 'ok'}
      check_order(pars['id'], pars['mc'], pars['txncd'])
    end

    if Rails.env.development?
      redirect_to("http://#{pars['p1']}:3000/carts/success")
    else
      redirect_to("http://#{pars['p1']}/carts/success")
    end

  end

  def manual_ipn

    require 'json'
    par = request.body.read

    pars = JSON.parse(par)

    check_order(pars['id'], pars['mc'], pars['txncd'])

    render :json => {'status': 'ok'}
  end

  def process_ipn_sub
    require 'json'
    #puts response.read_body
    pars = request.GET
    #pars2 = JSON.parse(pars)
    Iipn.create(pars.merge(id: nil))

    val = "#{ENV['ipay_vid']}";

    val1 = pars["id"];
    val2 = pars["ivm"];
    val3 = pars["qwh"];
    val4 = pars["afd"];
    val5 = pars["poi"];
    val6 = pars["uyt"];
    val7 = pars["ifd"];

    ipnurl = "https://www.ipayafrica.com/ipn/?vendor=#{val}&id=#{val1}&ivm=#{val2}&qwh=#{val3}&afd=#{val4}&poi=#{val5}&uyt=#{val6}&ifd=#{val7}"

    require 'net/http'

    uri = URI.parse(ipnurl)

    # Shortcut
    #response = Net::HTTP.post_form(uri, {"user[name]" => "testusername", "user[email]" => "testemail@yahoo.com"})

    # Full control
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    valcode = response.body

    if valcode == 'aei7p7yrx4ae34'
      #render :json => {'status': 'ok'}
      check_order(pars['id'], pars['mc'], pars['txncd'])
    end


    if Rails.env.development?
      redirect_to("http://#{pars['p1']}:3000/stores/premium")
    else
      redirect_to("http://#{pars['p1']}/stores/premium")
    end
  end

  def reconnect_premium(s, pid, expire)
    s.update(premium: true, active: true, activatable: true, plan_id: pid, premiumexpiry: expire, trial: false)
  end

  def reconnect(s, pid, expire)
    s.update(premium: false, active: true, plan_id: pid, activatable: true, premiumexpiry: expire, trial: false)
  end

  def total_days(expiry)
    if expiry.nil?
      expiry = DateTime.now
    end
    difference_in_days = (expiry - Date.today).to_i
  end

end

=begin
{
"Id":"Pi1_34714098-5612-cf57-3912-08d45bdc34qw",
"Type":1,"TypeDesc":"Account-To-Mobile",
"CompanyId":"7e1b82f6-f9cd-cb2c-d03c-08d1ddb81057",
"CompanyDesc":"Demo",
"Remarks":"Account to M-Pesa",
"CallbackURL":"http://yourEndpointURL/api/callback",
"IPNEnabled":true,
"IPNDataFormat":1,
"IPNDataFormatDesc":"JSON",
"IsDelivered":true,
"OrderLines":[{
  "Type":1,
  "TypeDesc":"Business Payment",
  "Payee":"JOHN DOE",
  "PrimaryAccountNumber":"254723123456",
  "Amount":5000.0000,
  "BankCode":null,
  "MCCMNC":63902,
  "MCCMNCDesc":"Kenya - Safaricom",
  "Reference":"c9ae5911-06a0-46df-bc49-04aad23er45r",
  "SystemTraceAuditNumber":"c9ae591106a046dfbc4904a8d123sdfg",
  "Status": 3,
  "StatusDesc":"Completed",
  "B2MResponseCode":"0",
  "B2MResponseDesc":"Accept the service request successfully.",
  "B2MResultCode":"0",
  "B2MResultDesc":"The service request is processed successfully.",
  "B2MTransactionID":"LBN464UBNH",
  "TransactionDateTime":"23.02.2017 11:03:52",
  "WorkingAccountAvailableFunds":500000.00,
  "UtilityAccountAvailableFunds":425079.00,
  "ChargePaidAccountAvailableFunds":0.00,
  "WalletAccountAvailableFunds":0.00,
  "TransactionCreditParty":"254723123456 - JOHN DOE",
  "IPNStatus":0,
  "IPNStatusDesc":"Pending",
  "IPNResponse":null}]
}


{"Id":"Pi1_73a20fa6-8593-c21b-09e4-08d635ae86ba",
"Type":1,
"TypeDesc":"Account-To-Mobile",
"CompanyId":"1997e1cc-bce7-ccbc-3073-08d5149a5027",
"CompanyDesc":"ZERONE I.T SOLUTIONS ",
"Remarks":"Transaction send 41 to 254724040839 at 2018-10-19 13:43:02 +0300",
"IPNEnabled":true,
"CallbackURL":"http://www.kduka.co.ke/ipn/b2c",
"IPNDataFormat":1,
"IPNDataFormatDesc":"JSON",
"IsDelivered":true,
"OrderLines":[{
"Type":1,
"TypeDesc":"Business Payment",
"Payee":"martin",
"PrimaryAccountNumber":"254724040839",
"Amount":41.0000,
"BankCode":null,
"MCCMNC":63902,
"MCCMNCDesc":"Kenya - Safaricom",
"Reference":"OH6ZQ7AFJW",
"Remark":null,
"SystemTraceAuditNumber":"Pi1_OH6ZQ7AFJW",
"RemitterName":null,
"RemitterAddress":null,
"RemitterPhoneNumber":null,
"RemitterIDType":null,
"RemitterIDNumber":null,
"RemitterCountry":null,
"RemitterCCY":null,
"RemitterFinancialInstitution":null,
"RemitterSourceOfFunds":null,
"RecipientName":null,
"RecipientAddress":null,
"RecipientPhoneNumber":null,
"RecipientIDType":null,
"RecipientIDNumber":null,
"PaymentPurpose":null,
"RemitterPrincipalActivity":null,
"PayeeAddress":null,
"PayeeIDNumber":null,
"Status":3,
"StatusDesc":"Completed",
"B2MResponseCode":"0",
"B2MResponseDesc":"Accept the service request successfully.",
"B2MResultCode":"0",
"B2MResultDesc":"The service request is processed successfully.",
"B2MTransactionID":"MJJ1C6ZBW5",
"ResponseCode":"0",
"ResponseDesc":"Accept the service request successfully.",
"ResultCode":"0",
"ResultDesc":"The service request is processed successfully.",
"TransactionID":"MJJ1C6ZBW5",
"TransactionReceipt":null,
"TransactionDateTime":"19.10.2018 13:44:21",
"WorkingAccountAvailableFunds":99554208.76,
"UtilityAccountAvailableFunds":14350404.15,
"ChargePaidAccountAvailableFunds":0.00,
"WalletAccountAvailableFunds":0.00,
"TransactionCreditParty":"254724040839 - MARTIN NDETO",
"IPNStatus":0,
"IPNStatusDesc":"Pending",
"IPNResponse":null}]}



=end
=begin

 <InstantPaymentNotification xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Id="Pi4_94bebd26-9393-c287-0651-08d5254a589a">
 	<MSISDN>254724040839</MSISDN>
 	<BusinessShortCode>766645</BusinessShortCode>
 	<InvoiceNumber></InvoiceNumber>
 	<TransID>LK612QR655</TransID>
 	<TransAmount>3.00</TransAmount>
 	<ThirdPartyTransID></ThirdPartyTransID>
 	<TransTime>20171106221246</TransTime>
 	<BillRefNumber>mart</BillRefNumber>
 	<OrgAccountBalance>18.00</OrgAccountBalance>
 	<KYCInfoList>
 		<KYCInfo>
 			<KYCName>[Personal Details][First Name]</KYCName>
 			<KYCValue>MARTIN</KYCValue>
 		</KYCInfo>
 		<KYCInfo>
 			<KYCName>[Personal Details][Middle Name]</KYCName>
 			<KYCValue>NGUI</KYCValue>
 		</KYCInfo>
 		<KYCInfo>
 			<KYCName>[Personal Details][Last Name]</KYCName>
 			<KYCValue>NDETO</KYCValue>
 		</KYCInfo>
 	</KYCInfoList>
 </InstantPaymentNotification>

=end

=begin
{
"txncd":"664093384",
"qwh":1501534703,
"afd":216710862,
"poi":383319515,
"uyt":319951150,
"ifd":1183332828,
"agt":"",
"id":"CX7BD2SN",
"status":"aei7p7yrx4ae34",
"ivm":"CX7BD2SN",
"mc":5454,
"p1":"",
"p2":"",
"p3":"",
"p4":"",
"msisdn_id":"m n",
"msisdn_idnum":"0724040839",
"msisdn_custnum":"0724040839",
"channel":"Credit_Card",
"tokenid":"demo",
"tokenemail":"martindeto@gmail.com",
"card_mask":"444444xxxxxx4444"}
=end
