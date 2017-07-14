class UsersController < ApplicationController
  def home
    set_admin
  end
  
  def stores
    @stores = Store.where(user_id:current_user.id)
    set_admin
  end
end
