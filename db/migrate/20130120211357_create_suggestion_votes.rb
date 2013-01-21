class CreateSuggestionVotes < ActiveRecord::Migration
  def change
    create_table :suggestion_votes do |t|
      t.integer :suggestion_id
      t.string :voter

      t.timestamps
    end
  end
end
