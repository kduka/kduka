class PaymentsMailer < ApplicationMailer
  def full_payment_recieved(o)
    @order = o
    mail(to: "test@kduka.co.ke", subject: "Full Payment Recieved Client", from: "Store Contact Form <test@kduka.co.ke>", reply_to:"test@kduka.co.ke")
  end


  def merchant_payment_recieved(o)
    @order = o
    mail(to: "test@kduka.co.ke", subject: "Merchant Email for recieved Payment", from: "Test <test@kduka.co.ke>", reply_to:"test@kduka.co.ke")
  end

  def partial_merchant_payment_recieved(o)
    @order = o
    mail(to: "test@kduka.co.ke", subject: "Merchant Email for recieved Partial Payment", from: "Test <test@kduka.co.ke>", reply_to:"test@kduka.co.ke")
  end

  def partial_payment_recieved(o)
    @order = o
    mail(to: "test@kduka.co.ke", subject: "Client Email for recieved Partial Payment", from: "Test <test@kduka.co.ke>", reply_to:"test@kduka.co.ke")
  end
end
