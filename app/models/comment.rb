class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :joke, polymorphic: true, counter_cache: true

  def hot?
    up_votes_count > 10
  end
end
