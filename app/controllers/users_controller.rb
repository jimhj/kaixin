class UsersController < ApplicationController
  before_action :no_login_required, only: [:new, :create]

  def new
    store_location params[:return_to]
    @user = User.new  
  end
  
  def create
    
  end

  def show
    render layout: 'detail'
  end
end