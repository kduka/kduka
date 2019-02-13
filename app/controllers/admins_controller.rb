class AdminsController < ApplicationController
  before_action :authenticate_admin!, except: [:ndeto]

  def index
    @stores = Store.all.order("created_at desc")
    @users = User.all.order("created_at desc")
    super_admin
  end

  def layouts
    @layouts = Layout.all
    super_admin
  end

  def ndeto

  end

  def init
    @store = Store.all
    @store.each do |store|
      @order = Order.where(store_id: store.id)
      @amount = 0
      @order.each do |o|
        if o.amount_received.nil?
          o.update(amount_received: 0)
        end
        @amount = @amount + o.amount_received

        if o.number_of_transactions.nil?
          o.update(number_of_transactions: 0)
        end
      end
      @store_amount = StoreAmount.where(store_id: store.id).first
      if @store_amount.nil?
        StoreAmount.create(store_id: store.id, amount: @amount)
      else
        @store_amount.update(amount: @amount)
      end
    end
  end

  def confirm_without_store
    users = User.where(confirm_without_store: nil)
    if !users.nil?
      users.each do |u|
        store = Store.where(user_id: u.id)
        if !store.nil?
          PromoteMailer.confirmed_without_store(u).deliver
          u.update(confirm_without_store: Time.now)
          puts u.name
        end
      end
    else
      puts "NOTHING"
    end
    redirect_to(admins_path)
  end

  def store_not_active
=begin
    users = User.where(store_not_active: nil)
    if !users.nil?
      users.each do |u|
        store = Store.where(user_id: u.id, active: false).first
        if !store.nil?
          PromoteMailer.store_not_active(u).deliver
          u.update(store_not_active:Time.now)
          puts u.name
        end
      end
    end
    redirect_to(admins_path)
=end
    order = Order.all
    order.each do |o|
      if o.date_placed.nil?
        order.update(date_placed2: o.created_at.strftime("%Y-%m-%-d"))
      else
        order.update(date_placed: o.created_at)
        order.update(date_placed2: o.date_placed.strftime("%Y-%m-%-d"))
      end
    end
  end

  def store_delete
    @store = Store.find(params[:id])
    event = Ahoy::Event.where(params[:id])

    if !event.nil?
      event.each do |e|
        e.destroy
      end
    end

    eve = Ahoy::Visit.where(params[:id])

    if !eve.nil?
      eve.each do |e|
        e.destroy
      end
    end

    if @store.destroy
      flash[:notice] = "Store Destroyed"
      redirect_to(request.referer)
    else
      flash[:alert] = "Something went wrong"
      redirect_to(request.referer)
    end
  end

  def view
    @store = Store.where(subdomain:params[:id]).first

    @products = @store.product.all

    @categories = @store.category.all

    super_admin
  end

  def upgrade
    #@TODO Send email to upgraded stores
    @store = Store.where(id:params[:id])
    up = @store.update(premium:true)
    if up
      flash[:notice] = "Store upgraded to premium"
      redirect_to(request.referer)
    else
      flash[:alert] = "Something went wrong"
      redirect_to(request.referer)
    end
  end

  def downgrade
    #@TODO Send email to downgraded stores
    @store = Store.where(id:params[:id])
    down = @store.update(premium:false,own_domain:false)
    if down
      flash[:notice] = "Store downgraded from premium"
      redirect_to(request.referer)
    else
      flash[:alert] = "Something went wrong"
      redirect_to(request.referer)
    end
  end

  def own_domain
    @store = Store.where(subdomain: params[:id])
    if @store.update(store_params)
      flash[:notice] = "Settings saved successfully"
      redirect_to(request.referer)
    else
      flash[:alert] = "An error occurred"
      redirect_to(request.referer)
    end
  end

  def allemails
    @stores = Store.all
    respond_to do |f|
      f.csv {send_data @products.to_csv}
      f.xls
    end
  end

  def feedback
    @feed = Feedback.all
    super_admin
  end

  def ipns
    @ipns = Iipn.all
    super_admin
  end

  def transactions
    @transactions = Order.where(:order_status_id => [2,6])
    super_admin
  end

  def transfers
    @transfers = Itransaction.all
    super_admin
  end

  def subscriptions
    @subscriptions = Subscription.where(:order_status_id => 6)
    super_admin
  end

  def earnings
    @earnings = Earning.all
    super_admin
  end

  private

  def store_params
    params.require(:store).permit(:own_domain,:domain, :c_subdomain)
  end

end
