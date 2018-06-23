class HomeController < ApplicationController
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

end
