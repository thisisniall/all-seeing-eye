class CreateTextMbs < ActiveRecord::Migration
  def change
    create_table :text_mbs do |t|
      t.references :textsearch, index: true, foreign_key: true
      t.string :personality_type
      t.float :value

      t.timestamps null: false
    end
  end
end
