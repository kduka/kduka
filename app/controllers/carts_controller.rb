class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
    set_shop

  end

  def shipping
    #require 'rubygems' if RUBY_VERSION < '1.9'
    #require 'rest-client'

    values = '{
  "command": "request",
  "data": {
    "api_key": "mysendykey",
    "api_username": "mysendyusername",
    "from": {
      "from_name": "Green House",
      "from_lat": -1.300577,
      "from_long": 36.78183,
      "from_description": ""
    },
    "to": {
      "to_name": "KICC",
      "lat":"-1.183333",
      "lng":"36.9166669",
      "to_description": ""
    },
    "recepient": {
      "recepient_name": "Sendy User",
      "recepient_phone": "0728561783",
      "recepient_email": "support@sendy.co.ke"
    },
    "delivery_details": {
      "pick_up_date": "2016-04-20 12:12:12",
      "collect_payment": {
        "status": false,
        "pay_method": 0,
        "amount": 10
      },
      "return": true,
      "note": " Sample note",
      "note_status": true,
      "request_type": "delivery",
      "order_type": "ondemand_delivery",
      "ecommerce_order": "ecommerce_order_001",
      "skew": 1,
      "package_size": [
        {
          "weight": 20,
          "height": 10,
          "width": 200,
          "length": 30,
          "item_name": "laptop"
        }
      ]
    }
  }
}'

    headers = {
        :content_type => 'application/json'
    }

    response = RestClient.post 'https://apitest.sendyit.com/v1/#request', values, headers

    @response = JSON.parse(response)

  set_shop
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

    
      if Rails.env.production?
        pesapal.config = {
      callback_url: request.subdomain+"."+request.domain+"/carts/complete",
      consumer_key: "631N8K73Vk8giRs+7L4LFLcJlfsI7FC0",
        #consumer_key: Rails.application.secrets.pesapal_consumer_key,
        consumer_secret: "qh2kfvUbcjgVNyTKCDizSK15D0M="
        #consumer_secret: Rails.application.secrets.pesapal_consumer_secret
        }
      else
       pesapal.config = {
      callback_url: request.subdomain+"."+request.domain+":3000/carts/complete",
      consumer_key: "631N8K73Vk8giRs+7L4LFLcJlfsI7FC0",
        #consumer_key: Rails.application.secrets.pesapal_consumer_key,
        consumer_secret: "qh2kfvUbcjgVNyTKCDizSK15D0M="
        #consumer_secret: Rails.application.secrets.pesapal_consumer_secret
        }
      end
        
        

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
    set_shop
  end


end
