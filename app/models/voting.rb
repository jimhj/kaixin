class Voting < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable,  polymorphic: true
  
  scope :comments, -> {
    where('votable_type' => 'Comment')
  }

  scope :jokes, -> {
    where('votable_type' => 'Joke')
  }
end
