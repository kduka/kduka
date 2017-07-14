class UsersController < ApplicationController
  before_action :authenticate_user!
  def home
    set_admin
  end
  
  def stores
    @stores = Store.where(user_id:current_user.id)
    set_admin
  end
end
