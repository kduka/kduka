class ApplicationController < ActionController::Base
=begin
protect_from_forgery with: :exception
=end
  helper_method :current_order, :sign, :sub
  
  def after_sign_in_path_for(resource)
    case resource
      when User then home_stores_path
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
      Order.find(session[:order_id])
    else
      ref = [*'A'..'Z', *"0".."9"].sample(8).join
      #@store  = Store.where(subdomain:request.subdomain).first
      Order.new(:ref => ref)
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
    render :layout => 'admin'
  end

  def set_shop_show
      @store = Store.find(current_store.id)
      render :layout => 'store_show'
  end
  
  def set_login
    render :layout => 'login'
  end

end
