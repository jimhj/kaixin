class TagsController < ApplicationController
  def index
    @tags = Tag.order('taggings_count DESC')  
  end


  def show
  end
end