class Admin::JokesController < Admin::ApplicationController
  def index
    @jokes = Joke.unscoped.preload(:comments, :user).order('created_at DESC')
    @jokes = @jokes.paginate(paginate_params)
  end

  def hot
    @jokes = Joke.unscoped.hot.paginate(paginate_params)
    render action: :index
  end

  def qutu
    @jokes = Joke.unscoped.qutu.paginate(paginate_params)
    render action: :index
  end

  def duanzi
    @jokes = Joke.unscoped.duanzi.paginate(paginate_params)
    render action: :index
  end

  def shenhuifu
    @jokes = Joke.unscoped.distinct.joins(:comments).where("comments.up_votes_count > 0").order('jokes.created_at DESC')
    @jokes = @jokes.paginate(paginate_params)
    render action: :index
  end


  def new
  end

  def create
  end

  def edit
  end

  def block
  end

  def recommend
  end

  private

  def joke_params
    params.require(:joke).permit(:title, :content, :anonymous, :photos => [])
  end

  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end  
end