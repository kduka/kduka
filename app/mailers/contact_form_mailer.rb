class ContactFormMailer < ApplicationMailer
  #default from: "contact-form@kduka.co.ke"

  def contact_form_email(message,email,name,to)
    @message =message
    @email = email
    @name = name

    mail(to: to, subject: "From " + name.to_s, from: "Store Contact Form <#{email}>", reply_to:email)
  end
end
