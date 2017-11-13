class UserPasswordsController < Devise::PasswordsController
# GET /resource/password/new
  def new
    self.resource = resource_class.new
    set_login
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
    store_login
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      #respond_with(resource)
      flash[:alert] = "Email not found!"
      redirect_to(request.referer)
    end
  end
end
