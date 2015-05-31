class TagsController < ApplicationController
  def index
    @tags = Tag.order('created_at DESC')
  end


  def show
    @tag = Tag.find_by! slug: params[:id]
    @jokes = @tag.jokes.preload(:comments, :user).order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end
end