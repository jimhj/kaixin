class JokesController < ApplicationController
  def index
  end

  def new
  end

  def show
    render layout: 'detail'
  end
end