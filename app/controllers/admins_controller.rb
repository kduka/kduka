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
    users = User.where(confirm_without_store:nil)
    if !users.nil?
      users.each do |u|
        store = Store.where(user_id: u.id)
        if !store.nil?
          PromoteMailer.confirmed_without_store(u).deliver
          u.update(confirm_without_store:Time.now)
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
        order.update(date_placed2:o.created_at.strftime("%Y-%m-%-d"))
      else
        order.update(date_placed:o.created_at)
      order.update(date_placed2:o.date_placed.strftime("%Y-%m-%-d"))
      end
    end
  end
end
