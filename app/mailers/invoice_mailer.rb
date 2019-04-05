class InvoiceMailer < ApplicationMailer

  def disconnect(s)
    @store=s
    attachments["#{s.name}_Invoice"] = File.read('path')

    mail(to: s.email,subject: "Invoice for #{s.name} has been suspended due to pending invoice.")
  end

  def send_first_invoice(s,iid)
    require 'fileutils'

    @store=s

    pdf = File.read("public/invoices/#{@store.id}/#{iid}_#{Time.now.strftime('%Y%m%d')}.pdf")

    attachments["#{iid}_#{Time.now.strftime('%Y%m%d')}.pdf"] = pdf

    mail(to: s.email,subject: "Invoice for #{s.name}")
  end


  def send_reminder(s)
    @store=s
    attachments["#{s.name}_Invoice"] = attachments["#{s.name}_Invoice"] = File.read('path')
    mail(to: s.email,subject: "#{s.name} is about to be suspended.")
  end
end
