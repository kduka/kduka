class ProductsController < ApplicationController
  before_action :authenticate_store!, only: [:manage, :category, :new, :create, :show, :edit, :update, :destroy]
  
  set_tab :home
  
  def index
  @subdomain = request.subdomain[/(\w+)/]
  @store  = Store.where(subdomain:@subdomain).first

    if @store.nil?
      redirect_to("http://www.kduka.co.ke/users/sign_in")
    else
      @products = Product.where(store_id:@store.id)
      @order_item = current_order.order_items.new
      @categories = @store.category.all
      render :layout => 'shop'
    end
 
=begin
  @store  = Store.where(id:params[:store_id]).first

    if @store.nil?
      redirect_to(stores_path)
    else
      @products = Product.where(store_id:@store.id)
      @order_item = current_order.order_items.new
      @categories = @store.category.all
      render :layout => 'shop'
    end
=end
    
  end
  
    def manage
      @categories = Category.where(store_id:current_store.id)
      @store = Store.find(current_store.id)
      @product = @store.product.all
      set_shop_show
    end
  
  def category
    @order_item = current_order.order_items.new
    @store  = Store.where(subdomain:request.subdomain).first
    @products = @store.product.where(category_id:params[:id])
    @categories = @store.category.all
      render :layout => 'shop'
  end

  def new
    @store = Store.find(current_store.id)
    @product = @store.product.new
    set_shop_show
  end

  def create
    @store = Store.find(current_store.id)
    sku = [*'A'..'Z', *"0".."9"].sample(8).join
    @product = @store.product.create(product_params.merge(sku:sku))
    
    
    if @product.save
      flash[:notice] = "New Product Created!"
      redirect_to(request.referer)
    else
      flash[:error] = "Error! couldnt save product"
      redirect_to(request.referer)
    end
  end
  
  def show
    @product = Product.find(params[:id])
    set_shop_show
  end
  
  def edit
    @product = Product.find(params[:id])
    @store = Store.find(current_store.id)
    set_shop_show
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product Successfully updated!"
    else
      flash[:alert] = "Something went wrong, try again"
    end
    
    redirect_to(store_product_path(params[:store_id],params[:id]))
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to(store_path(params[:store_id]))
  end
  private

  def product_params
    params.require(:product).permit(:name, :price, :active, :image, :category_id, :quantity)
  end
end
