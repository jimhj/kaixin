class Admin::CommentsController < Admin::ApplicationController

  def index
    @comments = Comment.preload(:user).order('created_at DESC').paginate(paginate_params)
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
  end

  private

  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end  
end