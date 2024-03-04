class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
    @title = "Cart"
    set_shop

  end

  def shipping
    if current_order.order_items.count.nil? or current_order.order_items.count == 0
      redirect_to(all_path) and return
    end
    @items = current_order.order_items.count
    @title = "Shipping"
    set_shop
  end

  def complete
    @order = Order.where(ref: params[:pesapal_merchant_reference]).first
    @order.update(order_status_id: 2)
    session[:ref] = nil
    session[:order_id] = nil
    redirect_to(cart_success_path)
  end

  def success
    @title = "Success"
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

  def sendy_call
    require 'uri'
    require 'net/http'

    par = request.body.read()

    print par

    if Rails.env.production?
      url = URI("https://api.sendyit.com/v1/")
    else
      url = URI("https://apitest.sendyit.com/v1/")
    end



    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = 'application/json'
    request["Cache-Control"] = 'no-cache'
    request["Postman-Token"] = 'cc060863-2567-6702-91b8-405910c6968c'
    request.body = par

    response = http.request(request)
    render :json => response.read_body
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
      puts "\n\n\n COUPON FOUND .... \n\n\n"
      if @coupon.number_of_use > 0
        puts "\n\n\n COUPON IS STILL VALID... \n\n\n"
        if @coupon.coupon_type == 'percent'
          puts "\n\n\n COUPON IS PERCENTAGE.... \n\n\n"
          discount = (@coupon.percentage.to_d/100) * current_order.total
          puts "\n\n\n DISCOUNT IS #{discount}.... \n\n\n"
          current_order.update(discount:discount,coupon:coupon)
        elsif @coupon.coupon_type == 'fixed'
          puts "\n\n\n COUPON IS FIXED.... \n\n\n"
          discount = @coupon.amount
          puts "\n\n\n DISCOUNT IS #{discount}.... \n\n\n"
          current_order.update(discount:discount,coupon:coupon)
        end
      end
    else
      puts "NO COUPON FOUND"
      current_order.update(coupon:"No Coupon",discount:0)
    end
    end

    @update = current_order.update(address: address, shipping: amount, delivery_order: orderid, delivery_type: type, name: name, email: email, phone: phone, del_location: delivery_location, del_lat: lat, del_long: lng, order_instructions: instructions)

    if @update
      cbk = "http://#{request.subdomain}.#{request.domain}/ipn/process_ipn"
      key = ENV['ipay_hash_key']
      p1 = "#{request.subdomain}.#{request.domain}"
      data = ENV['ipay_live']+current_order.ref+current_order.ref+current_order.total.to_s+current_order.phone+current_order.email+ENV['ipay_vid']+"KES"+ p1 + cbk + ENV['ipay_cst_flag'] + ENV['ipay_crl_flag']
      digest = OpenSSL::Digest.new('sha1')

      @hash = OpenSSL::HMAC.hexdigest(digest, key, data)
    end

  end

  def checkout

  end

  def red
    redirect_to(params[:url])
  end

  def pay
    lock_coupon
    @title = "Payment"
    set_shop
  end

  def confirm
    ref = params[:ref]
    @order = Order.where(ref:ref).first
    if @order.status == 'placed'
      session[:order_id]= nil
      @status = "complete"
    elsif @order.status == 'pending'
      bal = @order.total - @order.amount_received
      @status = "Incomplete Payment. Please send Ksh #{bal} to complete the Order"
    elsif @order.order_status_id == 'shipped'
      @status = "shipped"
    elsif @order.order_status_id == 'in_progress'
      @status = "none"
    end
    no_layout
  end

  def clear
    session[:order_id] = nil
  end


  private

  def lock_coupon
    @coupon = Coupon.find_by(code: current_order.coupon)
    if !@coupon.nil?
      if @coupon.number_of_use > 0
        nu = @coupon.number_of_use - 1
        @coupon.update(number_of_use:nu)
      else
        flash[:alert] = "Coupon is Invalid"
        current_order.update(coupon:"Invalid Coupon", discount:0)
      end
    end
  end


end
