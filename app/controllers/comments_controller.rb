class CommentsController < ApplicationController
  before_action :login_required, only: [:create]

  def index
    joke = Joke.find params[:joke_id]
    comments = joke.comments.order('created_at desc').limit(10)
    render partial: 'share/comments', locals: { comments: comments }, layout: false
  end

  def create
    joke = Joke.find params[:joke_id]
    comment = joke.comments.build
    comment.body = params[:body]
    comment.user = current_user
    if comment.save
      html = render_to_string(partial: 'comment', locals: { comment: comment })
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

  def up_vote
    @comment = Comment.find params[:comment_id]
    voting = @comment.up_votings.build
    voting.user = current_user
    voting.save

    render text: voting.to_json
  end
end