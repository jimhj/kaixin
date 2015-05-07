class UpVoting < Voting
  after_create do
    votable.increment :up_votes_count
    if votable.respond_to?(:hot)
      votable.update_hot 
    end
  end
end