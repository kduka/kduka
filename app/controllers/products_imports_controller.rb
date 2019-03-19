class ProductsImportsController < ApplicationController
  def new
  @products_import = ProductsImport.new
  set_shop_show
  end

def create
  @products_import = ProductsImport.new(params[:products_import])
  if @products_import.save
    redirect_to products_path
  else
    render :new
  end
end
end
