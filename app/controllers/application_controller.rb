class ApplicationController < ActionController::Base
=begin
protect_from_forgery with: :exception
=end
  helper_method :current_order, :sign, :sub
  def after_sign_in_path_for(resource)
    case resource
    when User then users_home_path
    when Store then stores_path
    end
  end

  def sub
    #@sub = "Subdomain: " + request.subdomain + "     Domain: " + request.domain + "     Truncated: " + request.subdomain[/(\w+)/]
  end

  def current_order
=begin
if !session[:order_id].nil?
Order.find(session[:order_id])
else
ref = [*'A'..'Z', *"0".."9"].sample(8).join
@store  = Store.where(subdomain:request.subdomain).first
Order.new(:ref => ref,:store_id => @store.id)
end
=end
    if !session[:order_id].nil?
      @find_order = Order.find(session[:order_id]) rescue nil
      if !@find_order
        session[:order_id]=nil
        current_order
      end
    else
      ref = [*'A'..'Z', *"0".."9"].sample(8).join
      @subdomain = request.subdomain[/(\w+)/]
      @store  = Store.where(subdomain:@subdomain).first
      Order.new(:ref => ref,store_id:@store.id)
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

  def set_shop
    @subdomain = request.subdomain[/(\w+)/]
    @store  = Store.where(subdomain:@subdomain).first

    if @store.nil?
      redirect_to("http://www.kduka.co.ke/users/sign_in") and return
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

  def get_store
    @subdomain = request.subdomain[/(\w+)/]
    @store  = Store.where(subdomain:@subdomain,active:true).first
  end

  def get_data
    @subdomain = request.subdomain[/(\w+)/]
    @store  = Store.where(subdomain:@subdomain,active:true).first

    if @store.nil?
      redirect_to("http://www.kduka.co.ke/users/sign_in") and return
    elsif @store.active == !true
    redirect_to("http://www.kduka.co.ke/users/sign_in") and return
      else
      @products = Product.where(store_id:@store.id,active:true)
      @order_item = current_order.order_items.new
      @categories = @store.category.all
      set_shop
    end
  end

end
