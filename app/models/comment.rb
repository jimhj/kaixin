class Comment < ActiveRecord::Base
  include Votable

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true

  # scope :hot, -> {
  #   preload(:commentable, :user).order('up_votes_count DESC, created_at DESC')
  # }

  scope :recent, -> {
    preload(:commentable, :user).order('comments.created_at DESC').limit(5)
  }

  def hot?
    self.id == commentable.hot_comment.try(:id)
    # false
  end

  def self.hot(limit = 5)
    cache_keys = Joke.order('created_at DESC').first(10000).map { |j| "joke:#{j.id}:hot_comment" }
    r = Rails.cache.read_multi(*cache_keys)
    r.values[0..limit]
  end
end
