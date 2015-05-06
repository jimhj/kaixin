class CommentsController < ApplicationController
  before_action :login_required

  def create
    joke = Joke.find params[:joke_id]
    comment = joke.comments.build
    comment.body = params[:body]
    comment.user = current_user
    if comment.save
      html = render_to_string(partial: 'share/comment_li', locals: { comment: comment })
      render :text => {
        success: true,
        html: html
      }.to_json
    else
      render :text => { 
        success: false, 
        error: comment.errors.full_messages.first 
      }.to_json
    end
  end
end