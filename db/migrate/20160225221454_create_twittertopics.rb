class CreateTwittertopics < ActiveRecord::Migration
  def change
    create_table :twittertopics do |t|
      t.references :twittersearch, index: true, foreign_key: true
      t.string :topic
      t.float :value

      t.timestamps null: false
    end
  end
end
