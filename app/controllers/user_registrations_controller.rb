class UserRegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    build_resource({})
    yield resource if block_given?
    respond_with resource do |format|
      format.html { set_login }
    end

  end

  # POST /resource
  def create
    @user = User.create(user_params)

    if @user.save
      flash[:notice] = "Registration Successful!"
      redirect_to(root_path)
    else
      flash[:notice] = "Sorry, SOmething went wrong"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :name)
  end

end
