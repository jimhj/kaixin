class JokesController < ApplicationController
  before_action :login_required, only: [:new, :create]

  def index
  end

  def new
  end

  def show
    render layout: 'detail'
  end
end