class SessionsController < ApplicationController
  before_action :no_login_required, only: [:new, :create]
  before_action :login_required, only: :destroy

  def new
    store_location params[:return_to]
    @page_title = "登录"
  end

  def create
    @user = if params[:login].include?('@')
      User.where(email: params[:login].downcase).first
    else
      User.where(login: params[:login].downcase).first
    end

    if @user && @user.authenticate(params[:password])
      login_as @user
      remember_me
      redirect_back_or_default root_url
    else
      flash[:error] = t('sessions.flashes.incorrect_email_or_password')
      redirect_to login_url
    end      
  end

  def destroy
    logout
    redirect_to root_url
  end

  def login_state
    # html = render_to_string(partial: 'share/u_center')
    # render text: html.to_json
    render template: 'share/_u_center', layout: false
  end
end