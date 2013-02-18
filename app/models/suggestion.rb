class Suggestion < ActiveRecord::Base
  has_many :suggestion_votes
  belongs_to :suggestion_category, :counter_cache => true

  attr_accessible :category, :description
  validates_presence_of :description

  def vote!(voter)
    unless(voted? voter)
      vote = SuggestionVote.create!(:voter => voter, :suggestion_id => id)
      self.suggestion_votes << vote
      save!
    end
  end

  def voted?(voter)
    suggestion_votes.find_by_voter(voter) != nil
  end

  def num_votes
    suggestion_votes_count || 0
  end


end
