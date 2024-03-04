class InvoiceMailer < ApplicationMailer

  def disconnect(s,inv)
    require 'fileutils'

    @store=s
    @invoice = inv


    if Rails.env.development?
      pdf = File.read("public/invoices/#{@store.id}/#{inv.uid}_#{s.name}.pdf")
    else
      pdf = open("#{inv.url}").read
    end

    attachments["#{inv.uid}_#{s.name}.pdf"] = pdf

    mail(to: s.email, from: "#{s.name} <no-reply@kduka.shop>", subject: "Your store #{s.name} has been suspended due to pending invoice.")

  end

  def send_first_invoice(s,inv)
    require 'fileutils'
    require 'open-uri'

    @store=s
    @invoice = inv

    if Rails.env.development?
      pdf = File.read("public/invoices/#{@store.id}/#{inv.uid}_#{s.name}.pdf")
    else
      pdf = open("#{inv.url}").read
    end

    attachments["#{inv.uid}_#{s.name}.pdf"] = pdf

    mail(to: s.email, from: "#{s.name} <no-reply@kduka.shop>", subject: "Invoice for #{s.name}")
  end


  def send_reminder(s,inv)

    @store=s
    @invoice = inv

    if Rails.env.development?
      pdf = File.read("public/invoices/#{@store.id}/#{inv.uid}_#{s.name}.pdf")
    else
      pdf = open("#{inv.url}").read
    end

    attachments["#{inv.uid}_#{s.name}.pdf"] = pdf

    mail(to: s.email, from: "#{s.name} <no-reply@kduka.shop>", subject: "Your store #{s.name} is about to be suspended")
  end
end
