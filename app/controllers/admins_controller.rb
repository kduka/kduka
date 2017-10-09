class AdminsController < ApplicationController
  before_action :authenticate_admin!, except:[:ndeto]

  def index
    @stores = Store.all
    @users = User.all
    super_admin
  end

  def layouts
    @layouts = Layout.all
    super_admin
  end

  def ndeto

  end
  
end
