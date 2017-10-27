class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
    set_shop

  end

  def shipping

    set_shop
  end

=begin
  def pay
    @user = User.find(1)
    # Configure transaction details
    pesapal = Pesapal::Merchant.new
    pesapal.order_details = {
        amount: current_order.subtotal,
        description: 'DESCRIPTION',
        type: 'MERCHANT',
        reference: session[:ref],
        first_name: params[:first_name],
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
=end

  def complete
    @order = Order.where(ref: params[:pesapal_merchant_reference]).first
    @order.update(order_status_id: 2)
    session[:ref] = nil
    session[:order_id] = nil
    redirect_to(cart_success_path)
  end

  def success
    set_shop
  end

  def auto
    @data = params[:cond]
    get_store
    no_layout
  end

  def manual
    get_store
    no_layout
  end

  def collection
    get_store
    no_layout
  end

  def location
    get_store

    @weight = 10
    @height = 10
    @width = 200
    @length = 10

    current_order.order_items.each do |oi|

      product = Product.find(oi.product_id)

      @weight = @weight + product.weight.to_i

      @height = @height + product.height.to_i

      if product.width.to_i > @width
        @width = product.width.to_i
      end

      if product.length.to_i > @length
        @length = product.width.to_i
      end
    end

    @locat = params[:delivery_location]
    @lng = params[:lng]
    @lat = params[:lat]
    @full_name = params[:full_name]
    @email = params[:email]
    @phone = params[:phone_number]
    no_layout
  end

  def update_shipping
    get_store
    amount = params[:amount]
    orderid = params[:orderid]
    type = params[:type]
    name = params[:name]
    phone = params[:phone]
    email = params[:email]
    delivery_location = params[:delivery_location]
    lat=params[:lat]
    lng = params[:lng]
    instructions = params[:instructions]
    coupon = params[:coupon]
    address = params[:address]


    if !coupon.nil?
    @coupon = Coupon.where(code:coupon).first
    if !@coupon.nil?
      if @coupon.number_of_use > 0
        if @coupon.coupon_type == 'percent'
          discount = (@coupon.percentage.to_d/100) * current_order.total
          current_order.update(discount:discount,coupon:coupon)
        elsif @coupon.coupon_type == 'fixed'
          discount = @coupon.amount
          current_order.update(discount:discount,coupon:coupon)
        end
      end
    else
      current_order.update(coupon:"Invalid Coupon",discount:0)
    end
    end

    current_order.update(address: address, shipping: amount, delivery_order: orderid, delivery_type: type, name: name, email: email, phone: phone, del_location: delivery_location, del_lat: lat, del_long: lng, order_instructions: instructions)

  end

  def checkout

  end

  def red
    redirect_to(params[:url])
  end

  def pay
    lock_coupon
    set_shop
  end

  def confirm
    if current_order.order_status_id == 2
      session[:order_id]= nil
      @status = "complete"
    elsif current_order.order_status_id == 5
      bal = current_order.total - current_order.amount_received
      @status = "Incomplete Payment. Please send Ksh #{bal} to complete the Order"
    elsif current_order.order_status_id == 1
      @status = "none"
    end
    no_layout
  end

  def clear
    session[:order_id] = nil
  end

  private

  def lock_coupon
    @coupon = Coupon.where(code: current_order.coupon).first

    if @coupon.number_of_use > 0
      nu = @coupon.number_of_use - 1
      @coupon.update(number_of_use:nu)
    else
      flash[:alert] = "Coupon is Invalid"
      current_order.update(coupon:"Invalid Coupon",discount:0)
    end
  end


end
