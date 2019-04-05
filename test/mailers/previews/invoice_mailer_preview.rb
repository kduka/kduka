# Preview all emails at http://localhost:3000/rails/mailers/invoice_mailer
class InvoiceMailerPreview < ActionMailer::Preview
  def disconnect()
    InvoiceMailer::disconnect(Store.find(1), nil)
  end

end
