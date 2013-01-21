class SuggestionVote < ActiveRecord::Base
  belongs_to :suggestion, :counter_cache => true

  attr_accessible :suggestion_id, :voter

end
