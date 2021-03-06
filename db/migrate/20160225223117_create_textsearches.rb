class CreateTextsearches < ActiveRecord::Migration
  def change
    create_table :textsearches do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :character_length
      t.float :sentiment
      t.float :personality_agreeableness
      t.float :personality_conscientiousness
      t.float :personality_extraversion
      t.float :personality_openness
      t.float :political_conservative
      t.float :political_green
      t.float :political_liberal
      t.float :political_libertarian

      t.timestamps null: false
    end
  end
end
