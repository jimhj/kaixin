class Comment < ActiveRecord::Base
  include Votable

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true

  def hot?
    self == commentable.hot_comment
  end
end
