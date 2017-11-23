# Preview all emails at http://localhost:3000/rails/mailers/promote_mailer
class PromoteMailerPreview < ActionMailer::Preview
  def confirmed_without_store()
    PromoteMailer.confirmed_without_store(User.find(1))
  end
  def store_not_active()
    PromoteMailer.store_not_active(User.find(1))
  end
end
