class UsersController < ApplicationController
  before_action :no_login_required, only: [:new, :create]

  def new
    store_location params[:return_to]
    @user = User.new  
  end
  
  def create
    @user = User.new params.require(:user).permit(:login, :email, :password)
    if @user.save
      login_as @user
      redirect_back_or_default root_url
    else
      render :new
    end    
  end

  def show
    render layout: 'detail'
  end
end