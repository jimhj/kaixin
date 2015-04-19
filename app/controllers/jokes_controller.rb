class JokesController < ApplicationController
  def index
    render layout: 'application'
  end

  def new
    render layout: 'application'
  end
end