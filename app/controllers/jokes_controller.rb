class JokesController < ApplicationController
  before_action :login_required, only: [:new, :create]

  def index
    @jokes = Joke.order('created_at DESC')
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
    render layout: 'detail'
  end

  private

  def joke_params
    params.require(:joke).permit(:title, :content, :photos, :anonymous)
  end
end