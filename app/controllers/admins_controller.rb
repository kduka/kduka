class AdminsController < ApplicationController
  def ndeto
    @stores = Store.all
    render :layout => false
  end
  
end
