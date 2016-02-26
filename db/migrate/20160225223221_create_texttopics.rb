class CreateTexttopics < ActiveRecord::Migration
  def change
    create_table :texttopics do |t|
      t.references :textsearch, index: true, foreign_key: true
      t.string :topic
      t.float :value

      t.timestamps null: false
    end
  end
end
