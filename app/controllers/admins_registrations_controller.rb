class AdminsRegistrationsController < Devise::RegistrationsController

  def edit
    super_admin
  end
end
