class CreateTwitterMbs < ActiveRecord::Migration
  def change
    create_table :twitter_mbs do |t|
      t.references :twittersearch, index: true, foreign_key: true
      t.string :personality_type
      t.float :value

      t.timestamps null: false
    end
  end
end
