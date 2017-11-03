# Preview all emails at http://localhost:3000/rails/mailers/payments_mailer
class PaymentsMailerPreview < ActionMailer::Preview
  def full_payment_recieved()
    PaymentsMailer.full_payment_recieved(Order.find(15))
  end

  def merchant_payment_recieved()
    PaymentsMailer.merchant_payment_recieved(Order.find(15))
  end
end
