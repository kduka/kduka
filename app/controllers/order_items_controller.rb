class OrderItemsController < ApplicationController
  before_action :get_store
  def create
    @order = current_order


    @order.order_items.each do |oi|

      if oi.product_id.to_s == params['order_item']['product_id']
        puts "FOUND"
      updater(oi.id,params['order_item']['quantity']) and return
      end
    end

    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id
    session[:ref] = @order.ref
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  def clear
    @order = current_order
    if current_order.order_status_id == 1
    @order.destroy
    end
    session[:order_id] = nil?
  end

  def updater(id,quantity)
    @order = current_order
    @order_item = @order.order_items.find(id)
    quantity = @order_item.quantity + quantity.to_i
    @order_item.update(quantity:quantity)
    #@order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
