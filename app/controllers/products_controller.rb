class ProductsController < ApplicationController
  before_action :authenticate_store!, only: [:manage, :new, :create, :show, :edit, :update, :destroy]

  set_tab :home

  def index
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == !true
      flash[:alert] = "Store is not active, please contact owner"
      redirect_to("http://www.kduka.co.ke/") and return
    else

      if @store.homepage_status == true
        @products = Product.where(store_id: @store.id, active: true)
        @order_item = current_order.order_items.new
        @categories = @store.category.all
        redirect_to(home_path) and return
      else
        redirect_to(about_path) and return
      end

    end
    set_shop
  end

  def home
    get_store
    if @store.blank?
      redirect_to(home_404_path) and return
    else
      @products = Product.where(store_id: @store.id, active: true).limit(3).order('id desc')
      @order_item = current_order.order_items.new
      @categories = @store.category.all
      @featured = @store.category.where(featured: true)
      set_shop
    end
  end

  def about
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.aboutpage_status == false
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
    @product = @store.product.all.order('id desc')
    set_shop_show
  end

  def category
    @order_item = current_order.order_items.new
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain).first
    @products = @store.product.where(category_id: params[:id], active: true).paginate(:page => params[:page], :per_page => 20).order('id desc')
    @categories = @store.category.all
    set_shop
  end

  def subcategory
    @order_item = current_order.order_items.new
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain).first
    @products = @store.product.where(category_id: params[:id], active: true).order('id desc')
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
      redirect_to(products_manage_path)
    else
      flash[:alert] = "Error! couldnt save product"
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
    if @store.nil?
      redirect_to(home_404_path) and return
    end

    @products = Product.where(store_id: @store.id, active: true).paginate(:page => params[:page], :per_page => 15).order('id desc')
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
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    end
    @product = Product.where(sku: params[:sku], active: true, store_id: @store.id).first
    if @product.nil?
      redirect_to(all_path) and return
    else
      viewed = @product.viewed += 1
      @product.update(viewed: viewed)
    end
    set_shop
  end

  def sort
    get_store
    sorter = params[:sorter]
    cat = params[:cat]

    if cat.blank?
      if sorter == 'nto'
        @products = Product.where(store_id: @store.id, active: true).order('created_at desc')
      elsif sorter == 'otn'
        @products = Product.where(store_id: @store.id, active: true).order('created_at asc')
      elsif sorter == 'htl'
        @products = Product.where(store_id: @store.id, active: true).order('price desc')
      elsif sorter == 'lth'
        @products = Product.where(store_id: @store.id, active: true).order('price asc')
      end
    else
      if sorter == 'nto'
        @products = Product.where(store_id: @store.id, active: true, category_id: cat).order('created_at desc')
      elsif sorter == 'otn'
        @products = Product.where(store_id: @store.id, active: true, category_id: cat).order('created_at asc')
      elsif sorter == 'htl'
        @products = Product.where(store_id: @store.id, active: true, category_id: cat).order('price desc')
      elsif sorter == 'lth'
        @products = Product.where(store_id: @store.id, active: true, category_id: cat).order('price asc')
      end
    end


    @order_item = current_order.order_items.new
    @categories = @store.category.all
    no_layout
  end

  def search
    get_store
    key = params[:key]
    #@products = Product.where(store_id: @store.id, active: true).order('created_at desc')
    if Rails.env.production?
      @products = Product.where("name ILIKE :query OR description ILIKE :query", query: "%#{key}%").where(store_id: @store.id, active: true,)
    else
      @products = Product.where("name LIKE :query OR description LIKE :query", query: "%#{key}%").where(store_id: @store.id, active: true,)
    end

    @order_item = current_order.order_items.new
    @categories = @store.category.all
    no_layout
  end

  def allproducts
    @products = Product.where(store_id:current_store.id)
    respond_to do |f|
      f.csv {send_data @products.to_csv}
      f.xls
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :active, :image, :category_id, :quantity, :img1, :length, :width, :height, :weight, :img2, :img3, :img4, :description)
  end

end
