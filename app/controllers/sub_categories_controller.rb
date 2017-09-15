class SubCategoriesController < ApplicationController
  def new
    valid = Category.where(id:params[:category_id],store_id:current_store.id)
    if valid.blank?
    redirect_to(categories_path) and return
    else
      @subcategory = SubCategory.new
     set_shop_show
     end
  end
  
  def create
    @category = Category.find(params[:category_id])  
    @subcategory = @category.sub_category.new(subcategory_params)

    
      if @subcategory.save
        redirect_to(category_path(params[:category_id]))
        flash[:notice] =  'Sub-category was successfully created.'
      else
        flash[:error] =  'Something went wrong.'
        redirect_to(category_path(params[:category_id]))
      end
    
  end

  def update
  end

  def destroy
    @subcat = SubCategory.find(params[:id])
    @del = @subcat.destroy
    
    if @del
      flash[:notice] = "Sub-category Deleted Successfully"
      redirect_to(category_path(params[:category_id]))
    else
      flash[:alert] = "Sorry Something went wrong"
      redirect_to(category_path(params[:category_id]))
    end
  end
  
  
  
  
  private 
  
   def subcategory_params
      params.require(:category).permit(:name, :description, :active)
    end
end
