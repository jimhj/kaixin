class Comment < ActiveRecord::Base
  include Votable

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true

  scope :hot, -> {
    preload(:commentable, :user).order('up_votes_count DESC, created_at DESC')
  }

  def hot?
    self.id == commentable.hot_comment.try(:id)
    # false
  end
end
