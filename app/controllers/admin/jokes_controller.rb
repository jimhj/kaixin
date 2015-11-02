class Admin::JokesController < Admin::ApplicationController
  before_action :find_joke, only: [:edit, :update, :approve, :reject, :recommend, :unrecommend]

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
      redirect_to admin_jokes_path
    else
      render :new
    end    
  end

  def edit
  end

  def update
    if @joke.update_attributes(joke_params)
      redirect_to admin_jokes_path
    else
      render :edit
    end
  end

  def approve
    @joke.approved!
  end

  def reject
    @joke.rejected!
  end

  def recommend
    @joke.update_attribute :recommended, true
  end

  def unrecommend
    @joke.update_attribute :recommended, false
  end

  private

  def find_joke
    @joke = Joke.find params[:id]
  end

  def joke_params
    params.require(:joke).permit(:title, :content, :anonymous, :tag_list, :video_url, :video_cover_url, :photos => [])
  end

  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end  
end