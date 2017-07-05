class OrderItemsController < ApplicationController
  def create
    @order = current_order

=begin
    @order.order_items.each do |oi|
      if oi.product_id == params[:product_id]

      end
    end
=end
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
    
    @order.destroy
    session[:order_id] = nil
    
  end

  def updater

  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
