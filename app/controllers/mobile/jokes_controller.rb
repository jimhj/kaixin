class Mobile::JokesController < Mobile::ApplicationController
  def index
    @jokes = Joke.preload(:comments, :user).order('created_at DESC')
    @jokes = @jokes.paginate(paginate_params)    
  end

  def show
    @joke = Joke.find params[:id]
    @tags = @joke.tags
    @comments = @joke.comments    
  end

  private
  
  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end  
end