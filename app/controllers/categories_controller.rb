class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where(store_id:params[:store_id])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    #@store = Store.find(params[:store_id])
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @store = Store.find(params[:store_id])
    @category = @store.category.new(category_params)

    
      if @category.save
        redirect_to(new_store_category_path(@store))
        flash[:notice] =  'Category was successfully created.'
      else
        redirect_to(new_store_category_path(@store))
      end
    
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
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
    redirect_to(store_categories_path(params[:store_id]))
    flash[:notice] =  'Category was successfully deleted.'
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
