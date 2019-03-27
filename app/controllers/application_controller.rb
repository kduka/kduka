class ApplicationController < ActionController::Base
=begin
protect_from_forgery with: :exception
=end
  helper_method :current_order, :sign, :can_be_active, :get_store

  def after_sign_in_path_for(resource)
    case resource
      when User then
        if resource.sign_in_count == 1
          PromoteMailer.confirmed_without_store(resource).deliver
        end
        users_home_path
      when Store then
        stores_path
      when Admin then
        admins_path
    end
  end

  before_action :configure_permitted_parameters, :store, if: :devise_controller? 

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      users_home_path
    elsif resource_or_scope == :admin
      admins_path
    elsif resource_or_scope == :store
      stores_path
    end
  end

  def current_order
    if !session[:order_id].nil?
      @find_order = Order.find(session[:order_id]) rescue nil
      if !@find_order
        session[:order_id] = nil
        current_order
      elsif @find_order.order_status_id != 1
        session[:order_id] = nil
        current_order
      else
        Order.find(session[:order_id])
      end
    else
      ref = [*'A'..'Z', *"0".."9"].sample(8).join
      del_code = [*'A'..'Z', *"0".."9"].sample(5).join
      @store = Store.where(c_subdomain:request.subdomain,domain:request.domain,own_domain:true).first

      if @store.nil?
        @subdomain = request.subdomain[/(\w+)/]
        @store = Store.where(subdomain: @subdomain).first
      end
      Order.new(:ref => ref, store_id: @store.id, delivery_code:del_code)
    end
  end

  def sign
    if user_signed_in?
      true
    else
      false
    end
  end

  set_tab :categories, :if => :controller?

  def controller?
    self.class.name =~ /^Stores(::|Controller)/
  end

  def set_admin
    render :layout => 'user_admin/admin'
  end

  def super_admin
    render :layout => 'super_admin/admin'
  end

  def set_shop
    @store = Store.where(c_subdomain:request.subdomain,domain:request.domain,own_domain:true).first

      if @store.nil?
        @subdomain = request.subdomain[/(\w+)/]
        @store = Store.where(subdomain: @subdomain).first
      end
    if @store.nil?
      redirect_to("http://www.kduka.co.ke/") and return
    end
    render :layout => "#{Layout.find(@store.layout_id).name}/shop"

  end

  def set_shop_show
    @store = Store.find(current_store.id)
    render :layout => 'store_admin/store_show'
  end

  def set_login
    render :layout => 'login/login'
  end

  def store_login
      render :layout => 'login/store_login'
  end


  def user_login
        render :layout => 'login/user_login'
    end

  def get_store
    puts "Subdomain is #{request.subdomain}"
    puts "Domain is #{request.domain}"
    @store = Store.where(c_subdomain:request.subdomain,domain:request.domain,own_domain:true).first

    if @store.nil?
      @subdomain = request.subdomain[/(\w+)/]
      @store = Store.where(subdomain: @subdomain).first
    end
  end

  def get_data
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == !true
      redirect_to(home_404_path) and return
    else
      @products = Product.where(store_id: @store.id, active: true)
      @order_item = current_order.order_items.new
      @categories = @store.category.where(active:true)
      set_shop
    end
  end

  def no_layout
    render layout: false
  end

  def can_be_active
    @store = Store.find(current_store.id)
    if @store.active == false && @store.important == true
        return true;
    end
  end

  def important
    @store = Store.find(current_store.id)
    messages = Hash.[]
    @i = 1

    @auto = @store.auto_delivery_status
    @manual = @store.manual_delivery_status
    @collection = @store.collection_point_status

    if (@auto == false || @auto == nil) && (@manual == false || @manual == nil ) && (@collection == nil || @collection == false)
      messages[@i] = "<a style='text-decoration:none;' href='#{stores_deliver_path}'>You need to setup a delivery option first! Click here.</a>"
      @i+=1
      messages[@i] = "<span style='text-decoration:none;color:#000'>Activate your Store</span>"
      deactivate_store
      @store.update(important:false)
    else
      @store.update(important:true)
    end
    return messages

  end

  def deactivate_store
    @store = Store.find(current_store.id)
    @store.update(active: false, important: false)
  end

  def setup
    @store= Store.find(current_store.id)
    messages = Hash.[]
    @i = 1
    cats = @store.category.all.first
    if cats.nil?
      messages[@i] = "<a style='text-decoration:none;' href='#{new_category_path}'>Click here to create a new category </a>"
      @i+=1
    end

    product = @store.product.all.first
    if product.nil?
      if cats.nil?
        messages[@i] = "<span style='color:black'>Create Products</span>"
      else
        messages[@i] = "<a style='text-decoration:none;' href='#{new_store_product_path(current_store.id)}'>Click here to create a new product</a>"
      end

      @i+=1
    end
    if !messages.empty?
      remove_init
    end

    return messages

  end


  def init_froala
    options = {
        # The name of your bucket.
        bucket: 'kduka2',

        # S3 region. If you are using the default us-east-1, it this can be ignored.
        region: ENV['aws_region2'],

        # The folder where to upload the images.
        keyStart: 'froala/',

        # File access.
        acl: 'public-read',

        # AWS keys.
        accessKey: ENV['aws_access_key_id'],
        secretKey: ENV['aws_secret_access_key']
    }

    # Compute the signature.
    @aws_data = FroalaEditorSDK::S3.data_hash(options)
  end

  def beforeFilter
    $request = request
  end

  def update_resource2(resource, params, current)

    store = Store.find_for_authentication(id: current_store.id)


    if params[:password] == params[:password_confirmation] && params[:password] != ""
      if store.valid_password?(current)
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

      if store.valid_password?(current)
        if params[:email] != ""
          store2 = Store.where(email:params[:email]).first
          if store2.nil?
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

  def store
    $store = current_store.id rescue nil
  end

  def remove_init
    @store = Store.find(current_store.id)
    @store.update(init: false)
  end
end
