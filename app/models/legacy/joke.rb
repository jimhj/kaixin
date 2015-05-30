class Legacy::Joke < Legacy::Base
  belongs_to :user
  has_many :comments

  def tags
    Legacy::Tag.joins(:taggings).where('taggings.taggable_id = ?', self.id)
  end

  def picture_url
    "http://static.kaixin100.com/uploads/joke/picture/#{self.id}/#{self.picture}"
  end
end