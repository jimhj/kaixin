class Legacy::User < Legacy::Base
  has_many :jokes
  has_many :comments

  def avatar_url
    "http://static.kaixin100.com/uploads/user/avatar/#{self.id}/#{self.avatar}"
  end
end