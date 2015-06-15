class Mobile::JokesController < Mobile::ApplicationController
  def index
    @jokes = Joke.preload(:comments, :user).order('created_at DESC')
    @jokes = @jokes.paginate(paginate_params) 
  end

  def hot
    @jokes = Joke.hot.paginate(paginate_params)
    @page_title = "热门笑话"
    render action: :index
  end

  def qutu
    @jokes = Joke.qutu.paginate(paginate_params)
    @page_title = "趣图"
    render action: :index
  end

  def duanzi
    @jokes = Joke.duanzi.paginate(paginate_params)
    @page_title = "段子"
    render action: :index
  end

  def shenhuifu
    @jokes = Joke.distinct.joins(:comments).where("comments.up_votes_count > 0").order('jokes.created_at DESC')
    @jokes = @jokes.paginate(paginate_params)
    @page_title = "神回复"
    render action: :index
  end

  def random
    @joke = Joke.random || Joke.order('hot DESC').first
    redirect_to joke_path(@joke)    
  end

  def show
    @joke = Joke.find params[:id]
    @tags = @joke.tags
    @comments = @joke.comments

    keywords = @tags.pluck(:name).to_a
    @page_title = @joke.title.presence || @joke.content
    @page_keywords = ([@page_title] + keywords).join(',')

    @page_description = if @joke.title.blank?
      ([@joke.content] + keywords).join(',')
    else
      ([@joke.title, @joke.content] + keywords).join(',')
    end

    set_meta_tags :title => @page_title,
                  :description => @page_description,
                  :keywords => @page_keywords,
                  :site => false            
  end

  def new
    @joke = current_user.jokes.new
    @page_title = "发表笑料"
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

  private
  
  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end  

  def joke_params
    params.require(:joke).permit(:title, :content, :anonymous, :photos => [])
  end  
end