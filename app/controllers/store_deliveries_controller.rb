class StoreDeliveriesController < ApplicationController
  before_action :authenticate_store!
  def create
    del_opt = params[:del_opt]
    del_price = params[:del_price]
    @del_opt = StoreDelivery.create(delivery_areas:del_opt,store_id:current_store.id,price:del_price)
  end

  def new
  end

  def destroy
    @store_delivery = StoreDelivery.find(params[:id]).destroy
  end
end
