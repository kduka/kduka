class ProductsController < ApplicationController
  before_action :authenticate_store!, only: [:manage, :new, :create, :show, :edit, :update, :destroy]

  set_tab :home

  def index
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain).first

    if @store.nil?
      redirect_to("http://www.kduka.co.ke/users/sign_in")
    else
      if @store.homepage_status == true
        @products = Product.where(store_id: @store.id)
        @order_item = current_order.order_items.new
        @categories = @store.category.all
        redirect_to(home_path) and return
      end

      if @store.homepage_status == false
        redirect_to(about_path) and return
      end
    end
    set_shop
  end


  def home
    get_data
  end

  def about
    get_store
    if @store.aboutpage_status == false
      redirect_to(all_path) and return
    else
      get_data
    end
  end

  def contact
    get_data
  end

  def manage
    @categories = Category.where(store_id: current_store.id)
    @store = Store.find(current_store.id)
    @product = @store.product.all
    set_shop_show
  end

  def category
    @order_item = current_order.order_items.new
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain).first
    @products = @store.product.where(category_id: params[:id])
    @categories = @store.category.all
    set_shop
  end

  def new
    @store = Store.find(current_store.id)
    @product = @store.product.new
    set_shop_show
  end

  def create
    @store = Store.find(current_store.id)
    sku = [*'A'..'Z', *"0".."9"].sample(8).join
    @product = @store.product.create(product_params.merge(sku: sku))


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

  def all
    get_store
    @products = Product.where(store_id: @store.id)
    @order_item = current_order.order_items.new
    @categories = @store.category.all
    set_shop
  end

  def update
    @product = Product.find(params[:id])
    @update =@product.update(product_params)
    if @update
      flash[:notice] = "Product Successfully updated!"
    else
      flash[:alert] = "Something went wrong, try again"
    end
    redirect_to(store_product_path(params[:store_id], params[:id]))
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to(store_path(params[:store_id]))
  end

  def view
    @product = Product.where(sku: params[:sku]).first
    set_shop
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :active, :image, :category_id, :quantity, :img1)
  end

end

