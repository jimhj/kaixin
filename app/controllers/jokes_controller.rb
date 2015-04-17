class JokesController < ApplicationController
  def index
  end

  def show
    render_layout
  end

  private

  def render_layout
    render :layout => 'detail'
  end
end