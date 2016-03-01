class AddTitleColumnToTextsearches < ActiveRecord::Migration
  def change
  	add_column :textsearches, :title, :string
  	remove_column :textsearches, :character_length, :integer
  end
end
