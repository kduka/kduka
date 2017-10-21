class IpnController < ApplicationController
  def index
    response = Hash.from_xml(request.body.read)
    r = response["InstantPaymentNofication"]
    msisdn = r["MSISDN"]
    business_short_code = r["BusinessShortCode"]
    invoice_number = r["InvoiceNumber"]
    trans_id = r["TransID"]
    trans_amount = r["TransAmount"]
    third_party_trans_id = r["ThirdPartyTransID"]
    trans_time = r["TransTime"]
    kyc_name = r["KYCInfo"]["KYCInfo"]["KYCName"]
    kyc_value = r["KYCInfo"]["KYCInfo"]["KYCValue"]

    @ipn = Ipn.create(MSISDN:msisdn,BusinessShortCode:business_short_code,InvoiceNumber:invoice_number,TransID:trans_id,TransAmount:trans_amount,ThirdPartyTransID:third_party_trans_id,TransTime:trans_time,KYCName:kyc_name,KYCValue:kyc_value)
    if @ipn
    render :json => {'status':'ok'}
      check_order(third_party_trans_id,trans_amount,trans_id)
    end
  end


    def check_order(ref,amount,transid)

      # BROKEN DOWN INCASE I NEED TO ADD MORE STUFF DEPENDING ON THE ORDER STATUS

    @order = Order.where(ref:ref).first

    if @order.nil?
      Unresolved.create(transid:transid)
    elsif @order.order_status_id == 5
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions:transactions,amount_received:newamount)

      complete(@order)
    elsif @order.order_status_id == 2
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions:transactions,amount_received:newamount)
      complete(@order)
    elsif @order.order_status_id == 1
      newamount = @order.amount_received.to_i + amount.to_i
      transactions = @order.number_of_transactions + 1
      @order.update(number_of_transactions:transactions,amount_received:newamount)
      complete(@order)
    end

    end

  def complete(ref)
    @order = ref
    if @order.total.to_i <= @order.amount_received.to_i
       @order.update(order_status_id:2)
       update_inventory(@order)
       PaymentsMailer.full_payment_recieved(@order).deliver
       PaymentsMailer.merchant_payment_recieved(@order).deliver
    else
      @order.update(order_status_id:5)
      PaymentsMailer.partial_payment_recieved(@order).deliver
      PaymentsMailer.partial_merchant_payment_recieved(@order).deliver
    end
  end

  def update_inventory(o)
    o.order_items.all.each do |oi|
      @product = Product.find(oi.product_id)
      nu = @product.quantity - oi.quantity
      sold = @product.number_sold += 1
      @product.update(quantity:nu,number_sold:sold)
    end
  end

end

=begin
<?xml version="1.0" encoding="utf-16"?>
    <InstantPaymentNofication xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Id="e8677df8-7036-c34b-6c30-08d2ba167992">
<MSISDN>245713047983</MSISDN>
       <BusinessShortCode>3434334</BusinessShortCode>
<InvoiceNumber>ABC123</InvoiceNumber>
       <TransID>hjfgerew</TransID>
<TransAmount>2000</TransAmount>
       <ThirdPartyTransID>XYZ</ThirdPartyTransID>
<TransTime>?</TransTime>
<KYCInfo>
<KYCInfo>
<KYCName>?</KYCName>
<KYCValue>?</KYCValue>
</KYCInfo>
       </KYCInfo>
</InstantPaymentNofication>
1401423339
=end
