class IpnController < ApplicationController
  def index

    response = Hash.from_xml(request.body.read)

    r = response["InstantPaymentNotification"]
    msisdn = r["MSISDN"]
    business_short_code = r["BusinessShortCode"]
    invoice_number = r["InvoiceNumber"]
    trans_id = r["TransID"]
    trans_amount = r["TransAmount"]
    third_party_trans_id = r["ThirdPartyTransID"]
    trans_time = r["TransTime"]
    bill_ref_no = r["BillRefNumber"]

    @ipn = Ipn.create(MSISDN: msisdn, BusinessShortCode: business_short_code, InvoiceNumber: invoice_number, TransID: trans_id, TransAmount: trans_amount, ThirdPartyTransID: third_party_trans_id, TransTime: trans_time,bill_ref_no:bill_ref_no)
    if @ipn
      render :json => {'status': 'ok'}
      check_order(bill_ref_no, trans_amount, trans_id)
    end



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
  end


  def check_order(ref, amount, transid)

    # BROKEN DOWN INCASE I NEED TO ADD MORE STUFF DEPENDING ON THE ORDER STATUS

    @order = Order.where(ref: ref).first

    if @order.nil?
      Unresolved.create(transid: transid)
    elsif @order.order_status_id == 5
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions: transactions, amount_received: newamount)
      complete(@order,amount)
    elsif @order.order_status_id == 2
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions: transactions, amount_received: newamount)
      complete(@order,amount)
    elsif @order.order_status_id == 1
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions: transactions, amount_received: newamount)
      complete(@order,amount)
    end

  end

  def complete(ref,amount)
    @order = ref
    store_amount(ref,amount)
    if @order.total.to_i <= @order.amount_received.to_i
      @order.update(order_status_id: 2)
      update_inventory(@order)
      PaymentsMailer.full_payment_recieved(@order).deliver
      PaymentsMailer.merchant_payment_recieved(@order).deliver
    else
      @order.update(order_status_id: 5)
      PaymentsMailer.partial_payment_recieved(@order).deliver
      PaymentsMailer.partial_merchant_payment_recieved(@order).deliver
    end
  end

  def update_inventory(o)
    o.order_items.all.each do |oi|
      @product = Product.find(oi.product_id)
      nu = @product.quantity - oi.quantity
      sold = @product.number_sold += 1
      @product.update(quantity: nu, number_sold: sold)
    end
  end

  def b2c
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
        end
      else
        @params["#{k}"] = a
      end
    end
    BusinessToConsumer.create(@params)
    render :json => @params

  end

  def store_amount(order,amount)
    @store_amount = StoreAmount.where(store_id: order.store_id).first
    if @store_amount.nil?
      StoreAmount.create(amount:0,store_id:order.store_id)
      @store_amount = StoreAmount.where(store_id: order.store_id).first
    end

    nu = @store_amount.amount + amount.to_i
    @store_amount.update(amount: nu)
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




=end


