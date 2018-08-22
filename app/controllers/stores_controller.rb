class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update]
  before_action :authenticate_store!, except: [:contact, :destroy]
  before_action :important, only: [:deliver, :index]

  def index

    @store = Store.find(current_store.id)
    @setup = setup
    if @store.init == false
      if setup.empty? && @store.important == true
        flash[:notice] = 'Congratulations! Your Account is all setup! Go to activation settings to activate it'
        @store.update(init: true)
      end
    end
    @important = important
    if @store.important != true
      if @important.empty? && @store.init == true
        flash[:notice] = 'Congratulations! Your Account is all setup! Go to activation settings to activate it'
        @store.update(important: true)
      end
    end
    @products = Product.where(store_id: current_store.id)
    @visitors = Ahoy::Visit.where(store_id: @store.id)
    set_shop_show
  end

  def show
    @store = Store.find(current_store.id)
    @product = Product.where(store_id: @store.id)
    set_shop_show
  end

  def new
    @store = Store.new
    set_login
  end

  def edit
    @store = Store.find(current_store.id)
    set_shop_show
  end

  def create
    @store = Store.new(store_params.merge(delivery_status: false, layout_id: 1))

    respond_to do |format|
      if @store.save
        format.html {redirect_to @store, notice: 'Store was successfully created.'}
        format.json {render :show, status: :created, location: @store}
      else
        format.html {render :new}
        format.json {render json: @store.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html {redirect_to @store, notice: 'Store was successfully updated.'}
        format.json {render :show, status: :ok, location: @store}
      else
        format.html {render :edit}
        format.json {render json: @store.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @store = Store.find(params[:id])
    if @store.destroy
      flash[:notice] = "Store Destroyed"
      redirect_to(request.referer)
    else
      flash[:alert] = "Something went wrong"
      redirect_to(request.referer)
    end
=begin
    respond_to do |format|
      format.html {redirect_to stores_url, notice: 'Store was successfully destroyed.'}
      format.json {head :no_content}
end
=end

  end

  def categories
    @categories = Category.where(store_id: current_store.id)
  end

  def orders
    @order = Order.where(store_id: current_store.id, order_status_id: [5, 2, 3, 6])
    @setup = setup
    @important = important
    set_shop_show
  end

  def account
    set_admin
  end

  def social
    @store = Store.find(current_store.id)
    @setup = setup
    @important = important
    set_shop_show
  end

  def update_social
    @store = Store.find(current_store.id)
    if @store.update(store_params)
      flash[:notice] = 'Links saved'
    else
      flash[:alert] = 'Something went wrong, please try again'
    end

    redirect_to(request.referer)

  end

  def update_store
    @store = Store.find(current_store.id)
    if @store.update(store_params)
      flash[:notice] = 'Settings Saved'
    else
      flash[:alert] = 'Something went wrong, please try again'
    end

    redirect_to(request.referer)

  end

  def layouts
    @store = Store.find(current_store.id)
    @layouts = Layout.all
    @setup = setup
    @important = important
    set_shop_show
  end

  def update_layout
    @store = Store.find(current_store.id)
    puts params[:store][:store_color]
    if @store.update(layout_id: params[:layout], store_color: params[:store][:store_color], store_font: params[:store][:store_font])
      flash[:notice] = 'Layout Updated'
    else
      flash[:alert] = 'Something went wrong, please try again'
    end

    redirect_to(request.referer)

  end

  def deliver
    @important = important
    @store = Store.find(current_store.id)
    @setup = setup
    @important = important
    set_shop_show
  end

  def update_delivery
    @store = Store.find(current_store.id)
    if @store.update(delivery_params)
      flash[:notice] = 'Pick up Location saved'
    else
      flash[:alert] = 'Something went wrong, please try again'
    end

    redirect_to(request.referer)

  end

  def pages
    @store = Store.find(current_store.id)
    @setup = setup
    @important = important
    init_froala
    set_shop_show
  end

  def update_pages
    @store = Store.find(current_store.id)
    if @store.update(pages_params)
      flash[:notice] = 'Pages Settings Saved'
    else
      flash[:alert] = 'Something went wrong, please try again'
    end
    redirect_to(request.referer)
  end

  def contact
    get_store
    @sendy = ContactFormMailer.contact_form_email(params[:message], params[:email], params[:first_name], @store.display_email).deliver
    if @sendy
      flash[:notice] = "Mail Sent"
    else
      flash[:notice] = "Not Sent"
    end
    redirect_to(request.referer)
  end

  def active
    @store = Store.find(current_store.id)
    if @store.important == false
      @important = important
      @setup = setup
      if @important.empty?
        @store.update(important: true)
      end
    end
    set_shop_show
  end

  def activate
    @store = Store.find(current_store.id)
    if @store.important == true
      if @store.update(active: true)
        flash[:notice] = "The store has been Activated"
        redirect_to(request.referer)
      else
        flash[:alert] = "Something went wrong. Please Try again"
        redirect_to(request.referer)
      end
    elsif @store.important == false
      redirect_to(stores_active_path)
    end
  end

  def deactivate
    @store = Store.find(current_store.id)
    if @store.update(active: false, important: false)
      flash[:notice] = "The store has been Deactivated"
      redirect_to(request.referer)
    else
      flash[:alert] = "Something went wrong. Please Try again"
      redirect_to(request.referer)
    end
  end


  def funds
    @find = StoreAmount.where(store_id: current_store.id).first
    @setup = setup
    @important = important
    if @find.nil?
      StoreAmount.create(amount: 0, actual: 0, lifetime_earnings: 0, store_id: current_store.id)
    end

    set_shop_show
  end

  def b2c
    name = params[:name]
    account = params[:phone]
    amount = params[:amount]


    @storeamount = StoreAmount.where(store_id: current_store.id).first
    @charges
    if @storeamount.amount > 500
      @temp = @storeamount.amount.to_i - 45
      @max = @temp - (@temp.to_d * 0.01).to_i
    else
      @temp = @storeamount.amount.to_i - 52
      @max = @temp - (@temp.to_d * 0.01).to_i
    end

    if amount.to_i > @max
      amount = @max
    end

    ref = [*'A'..'Z', *"0".."9"].sample(10).join
    uref = "Pi1_#{ref}"
    require 'uri'
    require 'net/http'

    url = URI("#{ENV['chase_endpoint']}")

    http = Net::HTTP.new(url.host, url.port)

    if Rails.env.production?
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["authorization"] = "#{ENV['auth_token']}"
    request["cache-control"] = 'no-cache'
    request.body = "{
                        'Type':1,
                        'CompanyId':'#{ENV['chase_id_api']}',
                        'Remarks':'Transaction send #{amount} to #{account} at #{Time.now}',
                        'IPNDataFormat':1,
                        'IPNEnabled':true,
                        'CallbackURL': '#{ENV['callback_url']}',
                        'OrderLines':[
                                      {
                                      'Payee':'#{name}',
                                      'PrimaryAccountNumber':'#{account}',
                                      'Amount':#{amount},
                                      'Reference':'#{ref}',
                                      'SystemTraceAuditNumber':'#{uref}',
                                      'MCCMNC':63902
                                      }
                                     ]
                   }"

    response = http.request(request)
    if response.kind_of? Net::HTTPSuccess
      puts "HTTP WORKED = #{response.read_body}"
      Transaction.create(account: account, name: name, trans_type: 'M-PESA', store_id: current_store.id, ref: ref, amount: amount, foreign_ref: response.read_body, transaction_status_id: 1)


      @storeamount = StoreAmount.where(store_id: current_store.id).first

      if amount.to_i > 500
        @trans_charges = 45.to_d + (amount.to_d * 0.01)
      else
        @trans_charges = 52.to_d + (amount.to_d * 0.01)
      end

      nu = @storeamount.amount.to_i - (amount.to_i + @trans_charges.to_i)
      nua = @storeamount.actual.to_i - (amount.to_i + @trans_charges.to_i)

      @storeamount.update(amount: nu, actual: nua)
      Earning.create(trans_id: response.read_body, store_id: current_store.id, amount: (@storeamount.amount.to_d * 0.01).to_i, ref: ref, transaction_status_id: 1);
      @status = true
    else
      @status = false
      puts "HTTP DIDNT = #{response.read_body}"
    end
    no_layout
  end

  def b2b
    name = params[:name]
    account = params[:account]
    amount = params[:amount]
    type = params[:type]


    @storeamount = StoreAmount.where(store_id: current_store.id).first
    @charges
    if @storeamount.amount > 500
      @temp = @storeamount.amount.to_i - 45
      @max = @temp - (@temp.to_d * 0.01).to_i
    else
      @temp = @storeamount.amount.to_i - 52
      @max = @temp - (@temp.to_d * 0.01).to_i
    end

    if amount.to_i > @max
      amount = @max
    end

    ref = [*'A'..'Z', *"0".."9"].sample(10).join
    uref = "Pi1_#{ref}"
    require 'uri'
    require 'net/http'

    url = URI("#{ENV['chase_endpoint']}")

    http = Net::HTTP.new(url.host, url.port)
    if Rails.env.production?
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["authorization"] = "#{ENV['auth_token']}"
    request["cache-control"] = 'no-cache'
    request.body = "{ 'Type':2,
                      'CompanyId':'#{ENV['chase_id_api']}',
                      'Remarks':'Transaction send #{amount} to #{account} at #{Time.now}',
                      'IPNDataFormat':1,
                      'IPNEnabled':true,
                      'CallbackURL':  '#{ENV['callback_url']}',
                      'OrderLines':[{ 'Type':#{type},
                                      'Payee':'#{name}',
                                      'PrimaryAccountNumber':'#{account}',
                                      'Amount':#{amount},
                                      'Reference':'#{ref}',
                                      'SystemTraceAuditNumber':'#{uref}'
                                    }]
                    }"
    puts request.body
    response = http.request(request)
    puts "AFTER REQUEST"
    if response.kind_of? Net::HTTPSuccess
      @type_n
      if type.to_i == 6
        @type_n = "Till Number"
      elsif type.to_i == 7
        @type_n = "Paybill"
      end

      puts type.to_s + " " + @type_n
      puts "HTTP WORKED = #{response.read_body}"
      Transaction.create(account: account, name: name, trans_type: @type_n, store_id: current_store.id, ref: ref, amount: amount, foreign_ref: response.read_body, transaction_status_id: 1)

      @storeamount = StoreAmount.where(store_id: current_store.id).first

      if amount.to_i > 500
        @trans_charges = 45.to_d + (amount.to_d * 0.01)
      else
        @trans_charges = 52.to_d + (amount.to_d * 0.01)
      end

      nu = @storeamount.amount.to_i - (amount.to_i + @trans_charges.to_i)
      nua = @storeamount.actual.to_i - (amount.to_i + @trans_charges.to_i)

      @storeamount.update(amount: nu, actual: nua)
      Earning.create(trans_id: response.read_body, store_id: current_store.id, amount: (@storeamount.amount.to_d * 0.01).to_i, ref: ref, transaction_status_id: 1);
      @status = true
    else
      @status = false
      puts "HTTP DIDNT = #{response.read_body}"
    end
    no_layout
  end

  def eft
    name = params[:name]
    account = params[:account]
    amount = params[:amount]
    bankcode = params[:bankcode]

    @storeamount = StoreAmount.where(store_id: current_store.id).first
    @charges
    if @storeamount.amount > 500
      @temp = @storeamount.amount.to_i - 45
      @max = @temp - (@temp.to_d * 0.01).to_i
    else
      @temp = @storeamount.amount.to_i - 52
      @max = @temp - (@temp.to_d * 0.01).to_i
    end

    if amount.to_i > @max
      amount = @max
    end


    ref = [*'A'..'Z', *"0".."9"].sample(10).join
    uref = "Pi1_#{ref}"
    require 'uri'
    require 'net/http'

    url = URI("#{ENV['chase_endpoint']}")

    http = Net::HTTP.new(url.host, url.port)
    if Rails.env.production?
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["authorization"] = "#{ENV['auth_token']}"
    request["cache-control"] = 'no-cache'
    request.body = "{ 'Type':0,
                      'CompanyId':'#{ENV['chase_id_api']}',
                      'Remarks':'Transaction send #{amount} to #{account} at #{Time.now}',
                      'IPNDataFormat':1,
                      'IPNEnabled':true,
                      'CallbackURL':  '#{ENV['callback_url']}',
                      'OrderLines':[{
                                      'Payee':'#{name}',
                                      'PrimaryAccountNumber':'#{account}',
                                      'Amount':#{amount},
                                      'BankCode':'#{bankcode}',
                                      'Reference':'#{ref}',
                                      'SystemTraceAuditNumber':'#{uref}',
                                      'MCCMNC':63902
                                    }]
                    }"
    puts request.body
    response = http.request(request)
    if response.kind_of? Net::HTTPSuccess
      puts "HTTP WORKED = #{response.read_body}"
      Transaction.create(account: account, name: name, trans_type: "EFT", store_id: current_store.id, ref: ref, amount: amount, foreign_ref: response.read_body, bankcode: bankcode, transaction_status_id: 1)

      @storeamount = StoreAmount.where(store_id: current_store.id).first

      if amount.to_i > 500
        @trans_charges = 45.to_d + (amount.to_d * 0.01)
      else
        @trans_charges = 52.to_d + (amount.to_d * 0.01)
      end

      nu = @storeamount.amount.to_i - (amount.to_i + @trans_charges.to_i)
      nua = @storeamount.actual.to_i - (amount.to_i + @trans_charges.to_i)

      @storeamount.update(amount: nu, actual: nua)
      Earning.create(trans_id: response.read_body, store_id: current_store.id, amount: (@storeamount.amount.to_d * 0.01).to_i, ref: ref, transaction_status_id: 1);
      @status = true
    else
      @status = false
      puts "HTTP DIDNT = #{response.read_body}"
    end
    no_layout
  end

  def order
    @order = Order.where(ref: params[:ref], store_id: current_store.id).first

    if @order.nil?
      flash[:alert] = "We couldnt find your order, please try again"
      redirect_to(request.referer) and return
    else
      if !@order.read
        @order.update(read: true)
      end
      @oi = OrderItem.where(order_id: @order.id)
      set_shop_show
    end


  end

  def sendy
    @username = params[:user]
    @key = params[:passw]
    @location = params[:loc]
    @lat = params[:lat]
    @lng = params[:lng]
    no_layout
  end

  def save_sendy
    @lat = params[:lat]
    @lng = params[:lng]
    @username = params[:user]
    @key = params[:passw]
    @location = params[:loc]
    @store = Store.find(current_store.id)
    @store.update(lat: @lat, lng: @lng, sendy_username: @username, sendy_key: @key, auto_delivery_location: @location);
  end

  def complete_order
    @store = Store.find(current_store.id)
    @orderno = params[:orderno]
  end

  def close_order
    code = params[:code]
    ref = params[:ref]
    @order = Order.where(ref: ref).first

    if @order.order_status_id == 6
      @status = "done"
    else
      if @order.delivery_code == code
        @order.update(order_status_id: 6, complete_date: Time.now)
        @store_amount = StoreAmount.where(store_id: current_store.id).first
        nu = @store_amount.amount.to_i + @order.amount_received.to_i
        @store_amount.update(amount: nu)
        @status = true
      else
        @status = false
      end
    end
  end

  def update_order2
    status = params[:status]
    ref = params[:ref]

    @order = Order.where(ref: ref).first

    @status = @order.update(order_status_id: status, ship_date: Time.now)

  end

  def update_order
    status = params[:status]
    ref = params[:ref]

    @order = Order.where(delivery_order: ref).first

    @status = @order.update(order_status_id: status, ship_date: Time.now)

  end

  def transactions
    set_shop_show
  end

  def myorders
    @orders = Order.where(store_id: current_store.id, order_status_id: [2, 3, 5, 6])
    respond_to do |f|
      f.xls
    end
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
    if response
      puts response
    else
    end
    render :json => response.read_body
  end

  def update_password
    @store = current_store
    if update_resource2(@store, pass_params, params[:store][:current_password])
      #flash[:notice] = "Well done"
      redirect_to(request.referer) and return
    else
      #flash[:alert] ="bULL SPIT"
      redirect_to(request.referer) and return
    end
  end

  def analytics
    #@TODO Find a secure way of inclusing these damn tags
    set_shop_show
  end

  def update_tag
    @store = current_store
    up = @store.update(gtag: params[:store][:gtag])

    if up
      flash[:notice] = "Google tag successfully updated"
      redirect_to(request.referer)
    else
      flash[:alert] = "Something went wrong"
      redirect_to(request.referer)
    end

  end

  def premium
    set_shop_show
  end

  def create_year
    exist = Subscription.where(order_status_id: 5, description: 'year', amount: 4500).first
    if exist.nil?
      @order = Subscription.create(amount: 4500, ref: [*'A'..'Z', *"0".."9"].sample(8).join, description: 'year', order_status_id: 5, store_id: current_store.id)
    else
      @order = exist
    end
    no_layout
  end

  def create_bi
    exist = Subscription.where(order_status_id: 5, description: 'bi', amount: 2395).first

    if exist.nil?
      @order = Subscription.create(amount: 2395, ref: [*'A'..'Z', *"0".."9"].sample(8).join, description: 'bi', order_status_id: 5, store_id: current_store.id)
    else
      @order = exist
    end
    no_layout
  end

  def create_month
    exist = Subscription.where(order_status_id: 5, description: 'month', amount: 420).first

    if exist.nil?
      @order = Subscription.create(amount: 420, ref: [*'A'..'Z', *"0".."9"].sample(8).join, description: 'month', order_status_id: 5, store_id: current_store.id)
    else
      @order = exist
    end
    no_layout
  end

  def confirm_sub
    ref = params[:ref]
    @order = Subscription.where(ref: ref).first
    if @order.order_status_id == 6
      @status = "complete"
    elsif @order.order_status_id == 5
      #bal = @order.amount - @order.amount_received
      @status = "Incomplete Payment. Please Contact us"
    elsif @order.order_status_id == 3
      @status = "shipped"
    elsif @order.order_status_id == 1
      @status = "none"
    end
    no_layout
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(current_store.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def store_params
    params.require(:store).permit(:facebook, :linkedin, :twitter, :instagram, :pinterest, :vimeo, :youtube, :slogan, :subdomain, :layout_id, :name, :phone, :display_email, :logo, :logo_status, :business_location, :active, :store_color, :store_font, :gtag)
  end

  def delivery_params
    params.require(:store).permit(:collection_point, :collection_point_status, :detailed_location, :manual_delivery_status, :manual_delivery_instructions, :auto_delivery_location)
  end

  def pages_params
    params.require(:store).permit(:homepage_status, :homepage_text, :aboutpage_status, :aboutpage_text, :contactpage_status, :phone, :display_email, :banner)
  end


end

def pass_params
  # NOTE: Using `strong_parameters` gem
  params.require(:store).permit(:password, :password_confirmation, :email)
end

