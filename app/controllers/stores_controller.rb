class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update]
  before_action :authenticate_store!, except: [:contact, :destroy]
  before_action :important, only: [:deliver, :index]

  # GET /stores
  # GET /stores.json
  def index

    @store = Store.find(current_store.id)
    @setup = setup
    if @store.init == false
      if setup.empty? && @store.important == true
        flash[:notice] = 'Congratulations! Your Account is all setup!'
        @store.update(init: true)
      end
    end
    @important = important
    if @store.important == false
      if @important.empty? && @store.init == true
        flash[:notice] = 'Congratulations! Your Account is all setup!'
        @store.update(important: true)
      end
    end
    @products = Product.where(store_id: current_store.id)
    set_shop_show
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(current_store.id)
    @product = Product.where(store_id: @store.id)
    set_shop_show
  end

  # GET /stores/new
  def new
    @store = Store.new
    set_login
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(current_store.id)
    set_shop_show
  end

  # POST /stores
  # POST /stores.json
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

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
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

  # DELETE /stores/1
  # DELETE /stores/1.json
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
    @order = Order.where(store_id: current_store.id, order_status_id: [5, 2])

    puts @order
    set_shop_show
  end

  def account
    set_admin
  end

  def social
    @store = Store.find(current_store.id)
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
    @store= Store.find(current_store.id)
    @layouts = Layout.all
    set_shop_show
  end

  def update_layout
    @store = Store.find(current_store.id)
    puts params[:store][:store_color]
    if @store.update(layout_id: params[:layout],store_color:params[:store][:store_color],store_font:params[:store][:store_font])
      flash[:notice] = 'Layout Updated'
    else
      flash[:alert] = 'Something went wrong, please try again'
    end

    redirect_to(request.referer)

  end

  def deliver
    @store = Store.find(current_store.id)
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

  def setup
    @store= Store.find(current_store.id)
    messages = Hash.[]
    @i = 1
    cats = @store.category.all.first
    if cats.nil?
      messages[@i] = "<a style='font-weight:bold;text-decoration:none;' href='#{new_category_path}'>Create Category </a>"
      @i+=1
    end

    product = @store.product.all.first
    if product.nil?
      if cats.nil?
        messages[@i] = "<span style='color:black'>Create Products</span>"
      else
        messages[@i] = "<a style='font-weight:bold;text-decoration:none;' href='#{new_store_product_path(current_store.id)}'>Create Products</a>"
      end

      @i+=1
    end
    if !messages.empty?
      remove_init
    end

    return messages

  end

  def funds
    @find = StoreAmount.where(store_id:current_store.id).first

    if @find.nil?
      StoreAmount.create(amount:0,store_id:current_store.id)
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
      @max = @temp - (@temp.to_d*0.01).to_i
    else
      @temp = @storeamount.amount.to_i - 52
      @max = @temp - (@temp.to_d*0.01).to_i
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
      Transaction.create(account:account,name:name,trans_type:'M-PESA',store_id:current_store.id,ref:ref,amount:amount,foreign_ref:response.read_body)


      @storeamount = StoreAmount.where(store_id: current_store.id).first

      if amount.to_i > 500
        @trans_charges = 45.to_d + (amount.to_d * 0.01)
      else
        @trans_charges = 52.to_d + (amount.to_d * 0.01)
      end

      nu = @storeamount.amount.to_i - (amount.to_i + @trans_charges.to_i)
      @storeamount.update(amount:nu)
      Earning.create(trans_id:response.read_body,store_id:current_store.id,amount:(@storeamount.amount.to_d * 0.01).to_i,ref:ref);
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
      @max = @temp - (@temp.to_d*0.01).to_i
    else
      @temp = @storeamount.amount.to_i - 52
      @max = @temp - (@temp.to_d*0.01).to_i
    end

    if amount.to_i > @max
      amount = @max
    end

    ref = [*'A'..'Z', *"0".."9"].sample(16).join
    uref = "Pi1_#{ref}"
    require 'uri'
    require 'net/http'

    url = URI("#{ENV['chase_endpoint']}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.read_timeout = 500

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
      Transaction.create(account:account,name:name,trans_type:@type_n,store_id:current_store.id,ref:ref,amount:amount,foreign_ref:response.read_body)

      @storeamount = StoreAmount.where(store_id: current_store.id).first

      if amount.to_i > 500
        @trans_charges = 45.to_d + (amount.to_d * 0.01)
      else
        @trans_charges = 52.to_d + (amount.to_d * 0.01)
      end

      nu = @storeamount.amount.to_i - (amount.to_i + @trans_charges.to_i)
      @storeamount.update(amount:nu)
      Earning.create(trans_id:response.read_body,store_id:current_store.id,amount:(@storeamount.amount.to_d * 0.01).to_i,ref:ref);
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
      @max = @temp - (@temp.to_d*0.01).to_i
    else
      @temp = @storeamount.amount.to_i - 52
      @max = @temp - (@temp.to_d*0.01).to_i
    end

    if amount.to_i > @max
      amount = @max
    end


    ref = [*'A'..'Z', *"0".."9"].sample(16).join
    uref = "Pi1_#{ref}"
    require 'uri'
    require 'net/http'

    url = URI("#{ENV['chase_endpoint']}")

    http = Net::HTTP.new(url.host, url.port)

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
      Transaction.create(account:account,name:name,trans_type:"EFT",store_id:current_store.id,ref:ref,amount:amount,foreign_ref:response.read_body,bankcode:bankcode)

      @storeamount = StoreAmount.where(store_id: current_store.id).first

      if amount.to_i > 500
        @trans_charges = 45.to_d + (amount.to_d * 0.01)
      else
        @trans_charges = 52.to_d + (amount.to_d * 0.01)
      end

      nu = @storeamount.amount.to_i - (amount.to_i + @trans_charges.to_i)
      @storeamount.update(amount:nu)
      Earning.create(trans_id:response.read_body,store_id:current_store.id,amount:(@storeamount.amount.to_d * 0.01).to_i,ref:ref);
      @status = true
    else
      @status = false
      puts "HTTP DIDNT = #{response.read_body}"
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
    params.require(:store).permit(:facebook, :linkedin, :twitter, :instagram, :pinterest, :vimeo, :youtube, :slogan, :subdomain, :layout_id, :name, :phone, :display_email, :logo, :logo_status, :business_location, :active, :store_color,:store_font)
  end

  def delivery_params
    params.require(:store).permit(:collection_point, :collection_point_status, :lng, :lat, :detailed_location, :auto_delivery_status, :sendy_username, :sendy_key, :manual_delivery_status, :manual_delivery_instructions, :auto_delivery_location)
  end

  def pages_params
    params.require(:store).permit(:homepage_status, :homepage_text, :aboutpage_status, :aboutpage_text, :contactpage_status, :phone, :display_email, :banner)
  end

  def important
    @store = Store.find(current_store.id)
    messages = Hash.[]
    @i = 1

    @auto = @store.auto_delivery_status
    @manual = @store.manual_delivery_status
    @collection = @store.collection_point_status

    if @auto == false && @manual == false && @collection == false
      messages[@i] = "<a style='font-weight:bold;text-decoration:none;' href='#{stores_deliver_path}'>You need to setup a delivery option first!</a>"
      @i+=1
      messages[@i] = "<span style='font-weight:bold;text-decoration:none;color:#000'>Activate your Store</span>"


      deactivate_store
    end


    return messages

  end

  def deactivate_store
    @store = Store.find(current_store.id)
    @store.update(active: false, important: false)
  end

  def remove_init
    @store = Store.find(current_store.id)
    @store.update(init: false)
  end
end
