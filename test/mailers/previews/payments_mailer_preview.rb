# Preview all emails at http://localhost:3000/rails/mailers/payments_mailer
class PaymentsMailerPreview < ActionMailer::Preview
  def full_payment_recieved()
    PaymentsMailer.full_payment_recieved(Order.find(19))
  end

  def merchant_payment_recieved()
    PaymentsMailer.merchant_payment_recieved(Order.find(15))
  end

  def full_subscription_payment_recieved
    o = Subscription.find(33)
    r = SubscriptionRecord.find(9)
    PaymentsMailer.full_subscription_payment_recieved(o,r)
  end
end
