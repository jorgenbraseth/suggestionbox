class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :id, :null => false
      t.string :category
      t.string :description

      t.timestamps
    end
  end
end
