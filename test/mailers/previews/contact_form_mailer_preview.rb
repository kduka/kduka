# Preview all emails at http://localhost:3000/rails/mailers/contact_form_mailer
class ContactFormMailerPreview < ActionMailer::Preview
  def sample
    ContactFormMailer.contact_form_email(User.first)
  end
end
