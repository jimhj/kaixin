class UsersController < ApplicationController
  before_action :check_if_block
  before_action :no_login_required, only: [:new, :create]

  def new
    store_location params[:return_to]
    @user = User.new  
    @page_title = "注册"
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
    @user = User.find params[:id]
    @jokes = @user.jokes.approved.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    @page_title = "#{@user.login}的所有笑料"
  end
end