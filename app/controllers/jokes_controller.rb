class JokesController < ApplicationController
  before_action :check_if_block
  before_action :login_required, only: [:new, :create]

  def index
    @jokes = Joke.approved.preload(:comments, :user).order('created_at DESC')
    @jokes = @jokes.paginate(paginate_params)
  end

  def hot
    @jokes = Joke.hot.paginate(paginate_params)
    @page_title = "热门笑话"
    render action: :index
  end

  def recommends
    @records = Joke.recommends.paginate(per_page: 18, page: params[:page], total_entries: 2000)
    @page_title = "热门笑料"
  end

  def qutu
    @jokes = Joke.qutu.paginate(paginate_params)
    @page_title = "趣图"
    render action: :index
  end

  def video
    @jokes = Joke.where.not(video_url: nil).preload(:comments, :user).order('created_at DESC')
    @jokes = @jokes.paginate(paginate_params)
    @page_title = '视频'
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

  def show
    @joke = Joke.find params[:id]
    if @joke.rejected?
      render status: 404, file: '/public/404.html', layout: false
      return      
    end

    if !@joke.video_url.blank? or !@joke.video_cover_url.blank?
      redirect_to root_url
      return
    end

    @tags = @joke.tags
    @comments = @joke.comments

    keywords = @tags.pluck(:name).to_a
    @page_title = @joke.title.presence || @joke.content.truncate(30)
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

  def search
    @jokes = Joke.search(
      query: {
        multi_match: {
          query: params[:q].to_s,
          fields: ['title', 'content']
        }
      },

      filter: {
        term: {
          status: 'approved'
        }
      }
    ).paginate(paginate_params).records
  end

  private

  def joke_params
    params.require(:joke).permit(:title, :content, :anonymous, :photos => [])
  end

  def paginate_params
    { page: params[:page], per_page: 10, total_entries: 2000 }
  end
end
