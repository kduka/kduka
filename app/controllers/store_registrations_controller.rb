class StoreRegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  prepend_before_action :kick_out, only: [:new, :create]

  def new
=begin
    @stores = Store.where(user_id: current_user.id).count

    if @stores > 2
      flash[:alert] = "You have reached the maximum number of stores allowed. Contact us to get more"
      redirect_to(users_home_path) and return
    end
=end

    @store = Store.new
    #store_login
  end

  # POST /resource
  def create
    # @user = User.find(current_user.id)
    # @store = @user.store.create(store_params.merge(subdomain: santize(params[:store][:subdomain]), layout_id: 1, store_color: '#fc711b', homepage_status: true, aboutpage_status: true, manual_delivery_status: false, auto_delivery_status: false, collection_point_status: false, init: false, important: false, active: false))
    @store = Store.create(store_params.merge(display_email:params[:store][:email],subdomain: santize(params[:store][:subdomain]), layout_id: 1, store_color: '#7aae42', homepage_status: true, aboutpage_status: true, manual_delivery_status: false, auto_delivery_status: false, collection_point_status: false, init: false, important: false, active: false))

    if @store.save
      flash[:notice] = "Your Store has been created! Please check your email for the activation message"
      #redirect_to(users_home_path)
      redirect_to(new_store_session_path)
      # store = Store.where(user_id:@user.id).first
      # if store.nil?
      # PromoteMailer.store_not_active(@user).deliver
      # end
    else
      flash[:notice] = "Sorry, we couldn't create the store. Please contact admin"
      redirect_to(new_store_session_path)
    end
  end

  # GET /resource/edit
  def edit
    @setup = setup
    @important = important
    set_shop_show
  end

  def update_password
    @store = current_store
    if update_resource2(@store, pass_params, params[:store][:current_password])
      #flash[:notice] = "Well done"
      redirect_to(request.referer) and return
    else
      #flash[:alert] ="bULL SPIT"
      redirect_to(request.referer) and return
    end
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

  def kick_out
    sign_out :store
  end


  private



  def store_params
    params.require(:store).permit(:email, :username, :password, :password_confirmation, :active, :name, :display_email, :phone, :subdomain)
  end

  def pass_params
    # NOTE: Using `strong_parameters` gem
    params.require(:store).permit(:password, :password_confirmation, :email)
  end


  def santize(name)
    lower = name.downcase
    nospace = lower.gsub(/[^0-9a-z]|(kduka\.co\.ke)|(kduka)/i, "")
    return nospace
  end

end