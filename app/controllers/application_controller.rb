class ApplicationController < ActionController::Base
=begin
  protect_from_forgery with: :exception
=end
  helper_method :current_order, :sign

  def current_order

    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
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
  
  
end
