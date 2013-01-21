class AddSuggestionVoteCountToSuggestion < ActiveRecord::Migration
  def change
    add_column :suggestions, :suggestion_votes_count, :integer
  end
end
