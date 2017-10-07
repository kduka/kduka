class AdminsSessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource)) do |format|
      format.html { set_login }
    end
  end
end
