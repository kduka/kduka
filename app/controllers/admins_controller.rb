class AdminsController < ApplicationController
  def ndeto
    @stores = Store.all
  end
  
end
