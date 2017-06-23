class ApplicationController < ActionController::Base
=begin
  protect_from_forgery with: :exception
=end
  helper_method :current_order

  def current_order

    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
end
