class JokesController < ApplicationController
  before_action :login_required, only: [:new, :create]

  def index
    @jokes = Joke.preload(:comments, :user).order('created_at DESC')
    @tags = Tag.order('taggings_count DESC').first(10)
  end

  def new
    @joke = current_user.jokes.new
    @joke.anonymous = true
  end

  def create
    @joke = current_user.jokes.build joke_params    
    @joke.photos = params[:joke][:photos]
    @joke.ip = request.remote_ip

    if @joke.save
      redirect_to @joke
    else
      render :new
    end    
  end

  def show
    @joke = Joke.find params[:id]
    @tags = @joke.tags
    @comments = @joke.comments
    render layout: 'detail'
  end

  def up_vote
    @joke = Joke.find params[:joke_id]
    voting = @joke.up_votings.build
    voting.user = current_user
    voting.save

    render text: voting.to_json
  end

  def down_vote
    @joke = Joke.find params[:joke_id]
    voting = @joke.down_votings.build
    voting.user = current_user
    voting.save
    
    render text: voting.to_json  
  end

  private

  def joke_params
    params.require(:joke).permit(:title, :content, :photos, :anonymous)
  end
end