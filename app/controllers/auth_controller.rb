class AuthController < ApplicationController
  before_action :no_login_required

  def weibo_callback
    callback :weibo
  end

  def qq_callback
    callback :qq
  end

  private

  def callback(source_type)
    auth = request.env["omniauth.auth"]
    Rails.logger.info auth
    user = User.find_or_create_by!("#{source_type}_uid" => auth.uid.to_s) do |u|
      if u.new_record?
        u.email = "#{SecureRandom.hex(6)}@#{source_type}.random.com"
        u.remote_avatar_url = File.join(auth.info.avatar_url, 'avatar.jpg')
        u.password = SecureRandom.hex(8)
        u.login = auth.info.name
      end
      u.send("#{source_type}_token=", auth.credentials.token)
    end

    login_as user
    remember_me
    redirect_back_or_default root_url root_url     
  end
end