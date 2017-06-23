class ProductsController < ApplicationController
  def index
    @stores  = Store.all
    @products = Product.where(store_id:params[:store_id])
    @order_item = current_order.order_items.new
  end
  def new
    @store = Store.find(params[:store_id])
    @product = @store.product.new
  end
  def create
  @store = Store.find(params[:store_id])
  @product = @store.product.create(product_params)

    if @product.save
      flash[:notice] = "New Product Created!"
      redirect_to(request.referer)
    else
      flash[:error] = "Error! couldnt save product"
      redirect_to(request.referer)
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :active)
  end
end
