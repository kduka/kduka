# Preview all emails at http://localhost:3000/rails/mailers/invoice_mailer
class InvoiceMailerPreview < ActionMailer::Preview
  def disconnect()
    InvoiceMailer::disconnect(Store.find(1), Invoice.where(store_id:1).first)
  end

  def send_first_invoice
    InvoiceMailer::send_first_invoice(Store.find(1), Invoice.where(store_id:1).first)
  end

  def send_reminder
    InvoiceMailer::send_reminder(Store.find(1), Invoice.where(store_id:1).first)
  end

end
