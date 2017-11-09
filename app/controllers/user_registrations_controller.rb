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
    @user = User.create(user_params.merge(init:false))
    if @user.save
      flash[:notice] = "Registration Successful! Please check your email for a confirmation message"
      redirect_to(request.referer)
    else
      flash[:notice] = "Sorry, Something went wrong. Please Contact Admin"
      redirect_to(request.referer)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :name)
  end

end
