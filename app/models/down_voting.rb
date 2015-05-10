class DownVoting < Voting
  after_create do
    votable.increment! :down_votes_count
    if votable.respond_to?(:hot)
      votable.update_hot 
    end  
  end
end