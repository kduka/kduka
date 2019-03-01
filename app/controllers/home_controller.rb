class HomeController < ApplicationController
  before_action :beforeFilter, only: :index

  def index
    ahoy.track "My first event", {language: "Ruby"}
    no_layout
  end

  def web_mail

    @deliver = ContactFormMailer.web_form_email(params[:message], params[:email], params[:name], params[:subject]).deliver

    if @deliver
      @status='true'
    else
      @status='false'
    end
    no_layout
  end

  def not_found
    no_layout
  end

  def error
    no_layout
  end

  def terms

  end

  def aup

  end

  def explore
    #retrieve all stores with explore enabled
    @category= ShopCategory.all
    @explore= Store.where(explore: 1)
    # @category = ShopCategory.find(params[:id])
    no_layout
  end

end
