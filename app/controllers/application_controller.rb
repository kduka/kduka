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

end
