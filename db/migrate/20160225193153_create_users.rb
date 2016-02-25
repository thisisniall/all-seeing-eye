class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :fname
      t.string :lname
      t.float :lat
      t.float :long

      t.timestamps null: false
    end
  end
end
