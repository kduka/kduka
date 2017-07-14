class StoreRegistrationsController < Devise::RegistrationsController
  
  
  
  def new
    @store = Store.new
    set_admin
  end
  
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
  
    # GET /resource/edit
  def edit
    
  end

  
    def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def store_params
    params.require(:store).permit(:email, :username, :password, :password_confirmation, :active, :name, :display_email, :phone, :subdomain)
  end


end