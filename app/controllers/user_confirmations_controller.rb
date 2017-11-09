class UserConfirmationsController < Devise::ConfirmationsController
  def new
    self.resource = resource_class.new
    store_login
  end

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      flash[:alert] = "This email is already confirmed!"
      redirect_to(request.referer)
    end
  end
end
