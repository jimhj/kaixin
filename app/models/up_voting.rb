class UpVoting < Voting
  after_create do
    votable.increment! :up_votes_count
    
    if votable.respond_to?(:hot)
      votable.update_hot 
    end

    if votable.is_a?(Comment) && 
       votable.commentable.comments.order('up_votes_count DESC').first == votable && 
       votable.up_votes_count > 5

       Rails.cache.write("joke:#{votable.commentable_id}:hot_comment", votable)
    end
  end
end