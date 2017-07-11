class ApplicationController < ActionController::Base
=begin
protect_from_forgery with: :exception
=end
  helper_method :current_order, :sign, :sub
  
  def sub
  @subdomain = request.subdomain.split('.').first
  @sub = "Subdomain: " + request.subdomain + "     Domain: " + request.domain 
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
    if params[:id].nil?
      @store = Store.find(params[:store_id])
      render :layout => 'store_show'
    else
      @store = Store.find(params[:id])
      render :layout => 'store_show'
    end
  end
  
  def set_login
    render :layout => 'login'
  end

end
