class ProductsImportsController < ApplicationController
  def new
  @products_import = ProductsImport.new
  set_shop_show
  end

def create
  @products_import = ProductsImport.new(params[:products_import])
   if @products_import.save
    flash[:notice] = "Products imported successfully!"
    redirect_to products_manage_path
  else
    flash[:alert] = "Products not imported. Kindly confirm the spreadsheet then try again."

    redirect_to products_imports_new_path(@products_import)
  end

end
def export
  @products = Product.where(store_id: current_store.id)
  @categories = Category.where(store_id: current_store.id)
  respond_to do |format|
   format.xlsx{
     response.headers[
       'Content-Disposition'
     ] = "attachment; filename= #{current_store.name}.xlsx"
   }

 end
end
end
