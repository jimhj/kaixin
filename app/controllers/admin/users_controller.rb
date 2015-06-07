class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.order('created_at DESC').paginate(paginate_params)
  end

  private

  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end  
end