class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @setup = setup
    @important = important
    @categories = Category.where(store_id:current_store.id)
    set_shop_show
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @subcategories = SubCategory.where(category_id:params[:id])
    set_shop_show
  end

  # GET /categories/new
  def new
    @category = Category.new
    set_shop_show
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    set_shop_show
  end

  # POST /categories
  # POST /categories.json
  def create
    @store = Store.find(current_store.id)
    @category = @store.category.new(category_params)

    
      if @category.save
        redirect_to(categories_path)
        flash[:notice] =  'Category was successfully created.'
      else
        redirect_to(new_category_path)
      end
    
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    redirect_to(categories_path)
    flash[:notice] =  'Category was successfully deleted.'
  end

  def feature
  @cat = Category.find(params[:id])
  @cat.update(featured:true)
    redirect_to(request.referer)
  end

  def unfeature
    @cat = Category.find(params[:id])
    @cat.update(featured:false)
    redirect_to(request.referer)
  end

  def setup
    @store= Store.find(current_store.id)
    messages = Hash.[]
    @i = 1
    cats = @store.category.all.first
    if cats.nil?
      messages[@i] = "<a style='text-decoration:none;' href='#{new_category_path}'>Click here to create a new category </a>"
      @i+=1
    end

    product = @store.product.all.first
    if product.nil?
      if cats.nil?
        messages[@i] = "<span style='color:black'>Create Products</span>"
      else
        messages[@i] = "<a style='text-decoration:none;' href='#{new_store_product_path(current_store.id)}'>Click here to create a new product</a>"
      end

      @i+=1
    end
    if !messages.empty?
      remove_init
    end

    return messages

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      #params.fetch(:category, {})
      params.require(:category).permit(:name, :description, :active)
    end
end
