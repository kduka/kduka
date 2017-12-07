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
      @subdomain = request.subdomain[/(\w+)/]
      @store = Store.where(subdomain: @subdomain).first
      if @store.nil?
        @store = Store.where(domain:request.domain,own_domain:true).first
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
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain).first
    if @store.nil?
      @store = Store.where(domain:request.domain,own_domain:true).first
    end
    if @store.nil?
      redirect_to("http://www.kduka.co.ke/users/home") and return
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
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain, active: true).first
    if @store.nil?
      @store = Store.where(domain:request.domain,own_domain:true).first
    end
  end

  def get_data
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain, active: true).first
    if @store.nil?
      @store = Store.where(domain:request.domain,own_domain:true).first
    end

    if @store.nil?
      redirect_to("http://www.kduka.co.ke/users/home") and return
    elsif @store.active == !true
      redirect_to("http://www.kduka.co.ke/users/home") and return
    else
      @products = Product.where(store_id: @store.id, active: true)
      @order_item = current_order.order_items.new
      @categories = @store.category.all
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



end
