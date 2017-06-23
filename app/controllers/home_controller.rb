class HomeController < ApplicationController
  def user
    if user_signed_in?
      @user = User.find(current_user.id)
      @stores = Store.where(user_id:current_user.id) rescue nil
    end

  end

  def store
  end
end
