class Settings::PasswordsController < ApplicationController
  def show
  end

  def update    
    if current_user.authenticate(params[:current_password])
      if current_user.update_attributes params.require(:user).permit(:password, :password_confirmation)
        flash[:success] = "密码更新成功"
        redirect_to :back
      else
        render :show
      end
    else
      flash[:error] = "当前密码输入错误"
      redirect_to :back
    end

  end
end