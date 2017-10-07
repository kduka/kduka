class UserPasswordsController < Devise::PasswordsController
# GET /resource/password/new
  def new
    self.resource = resource_class.new
    set_login
  end
end
