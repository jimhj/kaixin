class TagsController < ApplicationController
  def index
    @tags = Tag.order('created_at ASC')
    @page_title = "热门标签"
  end


  def show
    @tag = Tag.find_by! slug: params[:id]
    @jokes = @tag.jokes.preload(:comments, :user).order('created_at DESC').paginate(page: params[:page], per_page: 10)

    keywords = "tag爆笑图片,tag笑话".gsub!(/tag/, @tag.name)
    description = ("开心100与千万网友一起分享最新最热的tag、tag图片、tag动态图、冷笑话、糗事笑话、成人笑话、经典笑话、内涵段子等笑话大全").gsub!(/tag/, @tag.name)

    @page_keywords = @tag.seo_keywords.presence || keywords

    @page_title = if @tag.seo_title.blank?
      "#{@tag.name}_#{keywords.gsub!(/,\s?|，\s?/, '_')}"
    else
      "#{@tag.name}_#{@tag.seo_title}"
    end

    @page_description = if @tag.seo_description.blank?
      @sample_joke = @jokes.where.not(content: nil).sample
      @sample_joke.try(:content) || description
    else
      @tag.seo_description
    end
  end
end