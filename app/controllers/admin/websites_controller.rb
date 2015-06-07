class Admin::WebsitesController < Admin::ApplicationController
  before_action :find_website, only: [:edit, :update, :destroy]

  def index
    @websites = Website.order('priority DESC, created_at ASC').paginate(paginate_params)
  end

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(website_params)

    if @website.save
      redirect_to admin_websites_path
    else
      render action: :new
    end
  end

  def edit

  end

  def update
    if @website.update_attributes(website_params)
      redirect_to admin_websites_path
    else
      render action: :edit
    end    
  end

  def destroy
    @website.destroy
    redirect_to :back
  end

  private

  def find_website
    @website = Website.find params[:id]
  end

  def website_params
    params.require(:website).permit(:name, :url, :priority)
  end

  def paginate_params
    { page: params[:page], per_page: 40, total_entries: 2000 }
  end  
end