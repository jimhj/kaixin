class Admin::TagsController < Admin::ApplicationController
  before_action :find_tag, only: [:edit, :update]

  def index
    @tags = Tag.order('taggings_count DESC, created_at DESC').paginate(paginate_params)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @tag.update_attributes(tag_params)
      redirect_to admin_tags_path
    else
      render action: :edit
    end    
  end

  def search
    q = params[:q]
    @tags = Tag.where("name ~ '#{q}' or seo_title ~ '#{q}' or seo_description ~ '#{q}' or seo_keywords ~ '#{q}'").order('created_at DESC').paginate(paginate_params)
    render :index
  end

  private

  def find_tag
    @tag = Tag.find params[:id]
  end

  def tag_params
    params.require(:tag).permit(:name, :slug, :seo_title, :seo_keywords, :seo_description)
  end

  def paginate_params
    { page: params[:page], per_page: 40, total_entries: 2000 }
  end  
end