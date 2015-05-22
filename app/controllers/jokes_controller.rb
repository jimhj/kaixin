class JokesController < ApplicationController
  before_action :login_required, only: [:new, :create]
  before_action :find_jokes, only: %i(index hot qutu duanzi shenhuifu)

  def index
    @jokes = Joke.preload(:comments, :user).order('created_at DESC')
    @jokes = @jokes.paginate(page: params[:page], per_page: 10)
  end

  def hot
    @jokes = Joke.hot.paginate(page: params[:page], per_page: 10)
    render action: :index
  end

  def qutu
    @jokes = Joke.qutu.paginate(page: params[:page], per_page: 10)
    render action: :index
  end

  def duanzi
    @jokes = Joke.duanzi.paginate(page: params[:page], per_page: 10)
    render action: :index
  end

  def shenhuifu
    @jokes = Joke.joins(:comments)
    @jokes = @jokes.where("comments.up_votes_count > 0").order('created_at DESC')
    @jokes = @jokes.paginate(page: params[:page], per_page: 10)
    render action: :index
  end

  def new
    @joke = current_user.jokes.new
    @joke.anonymous = true
  end

  def create
    @joke = current_user.jokes.build joke_params    
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

  def find_jokes
    @jokes = Joke.preload(:comments, :user).order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def joke_params
    params.require(:joke).permit(:title, :content, :anonymous, :photos => [])
  end
end