class TagsController < ApplicationController
  def index
    @tags = Tag.order('created_at ASC')
    @page_title = "热门标签"
  end


  def show
    @tag           = Tag.find_by! slug: params[:id]
    @jokes         = @tag.jokes.preload(:comments, :user).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    
    title          = "tag笑话_tag笑话大全_笑话_开心100".gsub!(/tag/, @tag.name)
    keywords       = "tag,tag笑话".gsub!(/tag/, @tag.name)
    description    = ("开心100提供最新tag笑话、tag笑话大全等笑话信息，为您精心选择最经典的tag笑话、最搞笑的tag笑话、最内涵的tag笑话、最有深度的tag笑话大全等tag笑话。").gsub!(/tag/, @tag.name)
    
    @page_keywords = @tag.seo_keywords.presence || keywords
    @page_title = if @tag.seo_title.blank?
      title
    else
      "#{@tag.name}_#{@tag.seo_title}"
    end
    @page_description = @tag.seo_description.presence || description

    set_meta_tags :title => @page_title,
                  :description => @page_description,
                  :keywords => @page_keywords,
                  :site => false    
  end
end