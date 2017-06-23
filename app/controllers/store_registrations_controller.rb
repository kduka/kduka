class StoreRegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    @user = User.find(current_user.id)
    @store = @user.store.create(store_params)

    if @store.save
      flash[:notice] = "Done"
      redirect_to(root_path)
    else
      flash[:notice] = "Ooops"
    end
  end

  private

  def store_params
    params.require(:store).permit(:email, :username, :password, :password_confirmation, :active, :name)
  end

end