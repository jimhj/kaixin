module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votings, as: :votable, dependent: :destroy
    has_many :up_votings, as: :votable
    has_many :down_votings, as: :votable
  end

  def voted_by?(user)
    votings.where(user: user).exists?
  end 
end