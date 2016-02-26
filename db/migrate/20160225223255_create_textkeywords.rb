class CreateTextkeywords < ActiveRecord::Migration
  def change
    create_table :textkeywords do |t|
      t.references :textsearch, index: true, foreign_key: true
      t.string :keyword
      t.float :value

      t.timestamps null: false
    end
  end
end
