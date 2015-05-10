class UpVoting < Voting
  after_create do
    p 22222222
    votable.increment! :up_votes_count
    if votable.respond_to?(:hot)
      votable.update_hot 
    end
  end
end