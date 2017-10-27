class AdminsController < ApplicationController
  before_action :authenticate_admin!, except: [:ndeto]

  def index
    @stores = Store.all
    @users = User.all
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
        StoreAmount.create(store_id: store.id,amount:@amount)
      else
        @store_amount.update(amount: @amount)
      end
    end
  end

end
