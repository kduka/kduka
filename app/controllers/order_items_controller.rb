class OrderItemsController < ApplicationController
  before_action :get_store
  def create
    @order = current_order

    @product_id = params['order_item']['product_id']
    @order.order_items.each do |oi|

      if oi.product_id.to_s == @product_id
      updater(oi.id,params['order_item']['quantity']) and return
      end
    end

    @order_item = @order.order_items.new(order_item_params)
    @order.save
    @vars = Variant.where(product_id:@product_id)

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
    if current_order.status == 'in_progress'
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
