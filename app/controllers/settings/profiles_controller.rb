class Settings::ProfilesController < ApplicationController
  # layout 'detail'

  def show
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to :back
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :bio, :avatar)
  end
end