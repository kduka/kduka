class StorePasswordsController < Devise::PasswordsController
  def new
    self.resource = resource_class.new
    store_login
  end
end
