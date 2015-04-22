class DownVoting < Voting
  after_create do
    votable.increment :down_votes_count
    votable.update_hot
  end
end