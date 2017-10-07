class UserConfirmationsController < Devise::ConfirmationsController
  def new
    self.resource = resource_class.new
    set_login
  end
end
