module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votings, as: 'votable', dependent: :delete_all
  end

  def voted_by?(user)
    votings.where(user: user).exists?
  end

  # See https://gist.github.com/xdite/1391980
  def calculate_hot
    if !respond_to?(:up_votes_count) || !respond_to?(:down_votes_count)
      return 0
    end

    score = (up_votes_count - down_votes_count).abs
    order = Math.log10([score, 1].max)

    if score > 0
      sign = 1
    elsif score < 0
      sign = -1
    else
      sign = 0
    end

    seconds = created_at - DateTime.new(1970, 1, 1)
    long_num = order + sign * seconds / 45000
    (long_num * 10**7).round.to_f / (10**7)
  end

  def update_hot
    update_attribute :hot, calculate_hot
  end  
end