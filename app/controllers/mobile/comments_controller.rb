class Mobile::CommentsController < Mobile::ApplicationController
  before_action :login_required, only: [:new, :create]  

  def create
    joke = Joke.find params[:joke_id]
    @comment = joke.comments.build
    @comment.body = params[:body]
    @comment.user = current_user
    @comment.save 
  end
end