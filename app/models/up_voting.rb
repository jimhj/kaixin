class UpVoting < Voting
  after_create do
    votable.increment :up_votes_count
    votable.update_hot
  end
end