class UserRegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    build_resource({})
    yield resource if block_given?
    respond_with resource do |format|
      format.html { set_login }
    end

  end

  # GET /resource/edit
  def edit
    set_admin
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

  def update_password
    @user = current_user
    if update_resource2(@user, pass_params, params[:user][:current_password])
      #flash[:notice] = "Well done"
      redirect_to(request.referer) and return
    else
      #flash[:alert] ="bULL SPIT"
      redirect_to(request.referer) and return
    end
  end

  private

  def update_resource2(resource, params, current)

    user = User.find_for_authentication(id: current_user.id)


    if params[:password] == params[:password_confirmation] && params[:password] != ""
      if user.valid_password?(current)
        if resource.update(params)
          flash[:success] = "Success"
        else
          flash[:alert] = "Couldnt update password, try again later"
        end
      else
        flash[:alert] = "The current password you entered is wrong"
      end
    elsif params[:password] != params[:password_confirmation]
      flash[:alert] = "Passwords do not match"
    end

    if params[:password] == "" && params[:password_confirmation] == ""

      if user.valid_password?(current)
        if params[:email] != ""
          user2 = User.where(email:params[:email]).first
          if user2.nil?
            if resource.update(email:params[:email])
              flash[:notice] = "Email successfully changed"
            else
              flash[:alert] = "Couldn't change email"
            end
          else
            flash[:alert] = "Email already exists"
          end
        end

      else
        flash[:alert] = "The current password you entered is wrong"
      end
    end

  end

  def pass_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :email)
  end
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :name)
  end

end
