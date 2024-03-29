class UsersController < ApplicationController
  before_action :authenticate_user!, except:[:checkmail_user,:remote_santize,:checkmail]
  def home
    @stores = Store.where(user_id:current_user.id)
    @user = User.find(current_user.id)
    @setup = setup
    if @user.init == false
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
    nospace = lower.gsub(/[^0-9a-z]|(kduka\.co\.ke)|(kduka)/i, "")
    @domain = Store.where(subdomain:nospace).first

    if !@domain.nil?
      @nospace = 'false'
    else
      @nospace = nospace
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

  def checkmail_user
    email = params[:email]
    @email = User.where(email:email).first

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
    stores = @user.store.first

    if stores.nil?
      @user.update(init:false)
      messages[@i] = "<a style='font-weight:bold;text-decoration:none;' href='#{new_store_registration_path}'>Click here to create your first store! </a>"
      @i+=1
    else
      @user.update(init:true)
    end

    messages

  end


end
