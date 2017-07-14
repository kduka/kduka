class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def shipping

  end

  def pay
    @user = User.find(1)
    # Configure transaction details
    pesapal = Pesapal::Merchant.new
    pesapal.order_details = {
        amount: current_order.subtotal,
        description: 'DESCRIPTION',
            type: 'MERCHANT',
        reference: session[:ref],
        first_name:params[:first_name],
        last_name: params[:second_name],
        email: params[:email],
        phonenumber: params[:phone_number],
        currency: 'KES'
    }

    # Configure API settings while passing on the data that we need

    pesapal.config = {
        callback_url: request.subdomain+"."+request.domain+"/carts/complete",
        consumer_key: "631N8K73Vk8giRs+7L4LFLcJlfsI7FC0",
        #consumer_key: Rails.application.secrets.pesapal_consumer_key,
        consumer_secret: "qh2kfvUbcjgVNyTKCDizSK15D0M="
        #consumer_secret: Rails.application.secrets.pesapal_consumer_secret
    }

    # Generate iframe
    @order_url = pesapal.generate_order_url
    redirect_to @order_url
  end
  
  def complete
    @order = Order.where(ref:params[:pesapal_merchant_reference]).first
    @order.update(order_status_id:2)
    session[:ref] = nil
    session[:order_id] = nil
    redirect_to(cart_success_path)
  end
  
  def success
    
  end
end
