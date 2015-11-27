class Admin::UsersController < Admin::ApplicationController
  before_action :find_user, only: [:block, :unblock]

  def index
    @users = User.order('created_at DESC').paginate(paginate_params)
  end

  def block
    @user.block = true
    @user.save!
    redirect_to :back
  end

  def unblock
    @user.block = false
    @user.save!
    redirect_to :back    
  end

  private

  def find_user
    @user = User.find params[:id]
  end

  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end  
end