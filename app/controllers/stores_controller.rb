class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_store!
  #before_action :set_admin, only: [:index]
  #after_action :set_shop_show, only: [:show, :edit]
  set_tab :home

  # GET /stores
  # GET /stores.json
  def index
    @store = Store.where(user_id:current_store.id)
    @products = Product.where(store_id:current_store.id)
    set_shop_show
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id])
    @product = Product.where(store_id:@store.id)
    set_shop_show
  end

  # GET /stores/new
  def new
    @store = Store.new
    set_login
  end

  # GET /stores/1/edit
  def edit
    set_shop_show
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def categories
    @categories = Category.where(store_id:params[:store_id])
  end
  
  def orders
    @order = Order.where(store_id:params[:store_id],order_status_id:2)
    set_shop_show
  end
  
  def account
    set_admin
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end
    
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.fetch(:store, {})
    end
end
