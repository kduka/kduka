class AdminsRegistrationsController < Devise::RegistrationsController
  def new
    set_login
  end

  def edit
    super_admin
  end
end
