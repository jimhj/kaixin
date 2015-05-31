class JokesController < ApplicationController
  before_action :login_required, only: [:new, :create]

  def index
    @jokes = Joke.preload(:comments, :user).order('created_at DESC')
    @jokes = @jokes.paginate(paginate_params)
  end

  def hot
    @jokes = Joke.hot.paginate(paginate_params)
    render action: :index
  end

  def qutu
    @jokes = Joke.qutu.paginate(paginate_params)
    render action: :index
  end

  def duanzi
    @jokes = Joke.duanzi.paginate(paginate_params)
    render action: :index
  end

  def shenhuifu
    @jokes = Joke.distinct.joins(:comments).where("comments.up_votes_count > 0").order('jokes.created_at DESC')
    @jokes = @jokes.paginate(paginate_params)
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

  def joke_params
    params.require(:joke).permit(:title, :content, :anonymous, :photos => [])
  end

  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end
end