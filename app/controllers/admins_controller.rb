class AdminsController < ApplicationController
  def ndeto
    @stores = Store.all
    @users = User.all
    render :layout => false
  end
  
end
