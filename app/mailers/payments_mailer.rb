class PaymentsMailer < ApplicationMailer
  def full_payment_recieved(o)
    @order = o
    @orderitems = o.order_items.all
    @store = Store.find(o.store_id)
    mail(to: o.email, subject: "Payment Recieved [##{o.ref}]", from: "#{@store.name} <no-reply@kduka.co.ke>", reply_to:@store.display_email)
  end


  def merchant_payment_recieved(o)
    @order = o
    @orderitems = o.order_items.all
    @store = Store.find(o.store_id)
    mail(to: @store.display_email , subject: "New Order [##{o.ref}]", from:"#{@store.name} <no-reply@kduka.co.ke>", reply_to:o.email)
  end

  def partial_merchant_payment_recieved(o)
    @order = o
    @orderitems = o.order_items.all
    @store = Store.find(o.store_id)
    mail(to: o.email, subject: "Incomplete Payment Recieved [##{o.ref}]", from: "#{@store.name} <no-reply@kduka.co.ke>", reply_to:@store.display_email)
  end

  def partial_payment_recieved(o)
    @order = o
    @orderitems = o.order_items.all
    @store = Store.find(o.store_id)
    mail(to: @store.display_email , subject: "Incomplete Order Payment [##{o.ref}]", from:"#{@store.name} <no-reply@kduka.co.ke>", reply_to:o.email)
  end
end
