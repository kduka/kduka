class ProductsController < ApplicationController
  before_action :authenticate_store!, only: [:manage, :new, :create, :show, :edit, :update, :destroy]
  before_action :beforeFilter, only: :index
  set_tab :home

  def index

    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == false
      redirect_to(home_404_path) and return
    else
      if @store.homepage_status == true
        redirect_to(home_path) and return
      else
        redirect_to(about_path) and return
      end
    end
    set_shop
  end

  def full_site
    @store = Store.where(subdomain: 'test', active: true).first
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

    if !@store.homepage_status
      redirect_to(about_path) and return
    end
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == false
      redirect_to(home_404_path) and return
    else
      ahoy.track "home", {store: @store.id}
      @products = Product.where(store_id: @store.id, active: true).limit(3).order('id desc')
      @order_item = current_order.order_items.new
      @categories = @store.category.where(active: true)
      @featured = @store.category.where(featured: true)
      set_shop
    end
  end

  def about
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == !true
      redirect_to(home_404_path) and return
    else
      if @store.aboutpage_status == false
        redirect_to(all_path)
      else
        get_store
        ahoy.track "about", {store: @store.id}
        set_shop
      end
    end
  end

  def contact
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == !true
      redirect_to(home_404_path) and return
    else
      ahoy.track "contact", {store: @store.id}
      set_shop
    end
  end

  def manage
    @categories = Category.where(store_id: current_store.id)
    @store = Store.find(current_store.id)
    @product = @store.product.all.order('id desc')
    @setup = setup
    @important = important
    set_shop_show
  end

  def category
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == false
      redirect_to(home_404_path) and return
    else
      ahoy.track "category", {store: @store.id, category: params[:id].to_i}
      @order_item = current_order.order_items.new
      @products = @store.product.where(category_id: params[:id], active: true).paginate(:page => params[:page], :per_page => 20).order('id desc')
      @categories = @store.category.where(active: true)
      set_shop
    end
  end

  def subcategory
    @order_item = current_order.order_items.new
    @subdomain = request.subdomain[/(\w+)/]
    @store = Store.where(subdomain: @subdomain).first
    if @store.nil?
      @store = Store.where(domain: request.domain, own_domain: true).first
    end
    @products = @store.product.where(category_id: params[:id], active: true).order('id desc')
    @categories = @store.category.all
    set_shop
  end

  def new
    @store = Store.find(current_store.id)
    @product = @store.product.new
    init_froala
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
    init_froala
    set_shop_show
  end

  def all
    get_store
    if @store.nil?
      redirect_to(home_404_path) and return
    elsif @store.active == false
      redirect_to(home_404_path) and return
    else
      ahoy.track "all", {store: @store.id}
      @products = Product.where(store_id: @store.id, active: true).paginate(:page => params[:page], :per_page => 15).order('id desc')
      @order_item = current_order.order_items.new
      @categories = @store.category.where(active: true)
      set_shop
    end
  end

  def update
    @product = Product.find(params[:id])
    @update = @product.update(product_params)
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
    flash[:notice] = "Product was deleted successfully!"
    redirect_to(request.referer)
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
    @products = Product.where(store_id: current_store.id)
    respond_to do |f|
      f.csv {send_data @products.to_csv}
      f.xls
    end
  end

  def add_variant
    value = "{\"0\":\"#{params[:variant_value]}\"}"

    @id = params[:id]
    @name = params[:variant_name].downcase

    exist = Variant.where(name: @name, product_id: @id)

    if exist.blank?
      puts 'true'
      @var = Variant.create(name: @name, value: value, product_id: @id)
    else
      puts 'false'
      @var = 'exist'
    end
  end

  def delete_variant
    require 'json'
    @name = params[:name]
    @index = params[:index]
    @id = params[:product_id]

    var = Variant.where(name: @name, product_id: @id).first

    @str = JSON.parse(var.value)
    @str.delete(@index)

    if @str.blank?
      var.destroy
    else
      res = var.update(value: @str.to_json)
      if res
        @var = true
      else
        @var = 'error'
      end
    end

  end

  def append_variant

    @id = params[:id]
    @name = params[:variant_name].downcase
    @variant_value = params[:variant_value].downcase
    vars = Variant.where(name: @name, product_id: @id).first
    @vals = JSON.parse(vars.value)

    key = 0

    @vals.each do |k, v|
      if v == @variant_value
        @res = false
      else
        if k.to_i > key.to_i
          key = k
        end
      end
    end

    key = key.to_i + 1

    @vals[key] = @variant_value

    vars.update(value: @vals.to_json)

    #@TODO Check if color already exists before adding
    #

  end

  def collect_vars
    require 'json'
    @vars = Variant.where(product_id: params[:product_id])
    @hash = Hash.[]
    i = 0
    @vars.each do |v|
      @hash["#{i}"] = v.name
      i += 1
    end
    respond_to do |format|
      format.json {render :json => @hash}
    end
  end

  def final_variants
    ois = current_order.order_items.where(product_id: params[:product_id])

    if ois.update(variants: params[:vars])
      @res = 'true'
    else
      @res = 'false'
    end
    no_layout
  end

  def duplicate
    @product = Product.where(store_id: current_store.id, id: params[:id]).first

    if @product.nil?
      flash[:alert] = "Error: Product does not exist"
      redirect_to(request.referer)
    else
      sku = [*'A'..'Z', *"0".."9"].sample(8).join
      new = @product.dup

      if new.update(sku: sku, created_at: nil, updated_at: nil, viewed: 0, number_sold: 0, image: nil, img1: nil, img2: nil, img3: nil, img4: nil)
        flash[:notice] = "Product Successfully Duplicated!"
        redirect_to(edit_store_product_path(current_store.id, new.id))
      else
        flash[:alert] = "Error: Something went wrong"
        redirect_to(request.referer)
      end

    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :active, :image, :category_id, :quantity, :img1, :length, :width, :height, :weight, :img2, :img3, :img4, :description, :discount_price, :discount_status, :long_description)
  end

end
