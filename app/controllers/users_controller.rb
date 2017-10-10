class UsersController < ApplicationController
  before_action :authenticate_user!
  def home
    @user = User.find(current_user.id)
    if @user.init == nil
      @setup = setup
      if setup.empty?
        flash[:notice] = "Congratulations! Your Account is all setup!"
        @user.update(init:true)
      end
    end

    set_admin
  end
  
  def stores
    @stores = Store.where(user_id:current_user.id)
    set_admin
  end


  def remote_santize
    name = params[:url]
    lower = name.downcase
    nospace = lower.gsub(/[^0-9a-z]/i, "")
    @domain = Store.where(subdomain:nospace).first

    if !@domain.nil?
      @nospace = "<span style='color:red'>The domain http://#{nospace}.kduka.co.ke is already taken</span>"
    else
      @nospace = "<span style='color:green'>http://#{nospace}.kduka.co.ke</span>"
    end

    no_layout
  end

  def checkmail
    email = params[:email]
    @email = Store.where(email:email).first

    if !@email.nil?
      @email = "<span style='color:red'>This email is already taken!</span>"
    else
      @email = "<span style='color:green'>Available</span>"
    end

    no_layout
  end

private
  def setup
    @user = User.find(current_user.id)
    messages = Hash.[]
    @i = 1
    stores = @user.store.all
    if stores.nil?
      messages[@i] = "<a style='font-weight:bold;text-decoration:none;' href='#{new_store_registration_path}'>Create your first store! </a>"
      @i+=1
    else
      @user.store.update(init:true)
    end

    return messages

  end


end
