class PromoteMailer < ApplicationMailer
  def confirmed_without_store(id)
    @user = id
    mail(to: id.email, subject: "Setup your first store", from: "KDuka <no-reply@kduka.co.ke>")
  end

  def store_not_active(id)
    @user = id
    mail(to: id.email, subject: "Get your store running", from: "KDuka <no-reply@kduka.co.ke>")
  end
end
