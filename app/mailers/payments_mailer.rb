class PaymentsMailer < ApplicationMailer
  def full_payment_recieved(o)
    @order = o
    @orderitems = o.order_items.all
    @store = Store.find(o.store_id)
    mail(to: o.email, subject: "Payment Recieved [#{o.ref}]", from: "#{@store.name} <no-reply@kduka.co.ke>", reply_to:@store.display_email)
  end


  def merchant_payment_recieved(o)
    @order = o
    @orderitems = o.order_items.all
    @store = Store.find(o.store_id)
    mail(to: @store.display_email , subject: "New Order #{o.ref}", from:"#{@store.name} <no-reply@kduka.co.ke>", reply_to:o.email)
  end

  def partial_merchant_payment_recieved(o)
    @order = o
    mail(to: "test@kduka.co.ke", subject: "Merchant Email for recieved Partial Payment", from: "Test <test@kduka.co.ke>", reply_to:"test@kduka.co.ke")
  end

  def partial_payment_recieved(o)
    @order = o
    mail(to: "#{o.email}", subject: "Client Email for recieved Partial Payment", from: "Test <test@kduka.co.ke>", reply_to:"test@kduka.co.ke")
  end
end
