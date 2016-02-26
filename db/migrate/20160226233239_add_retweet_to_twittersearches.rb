class AddRetweetToTwittersearches < ActiveRecord::Migration
  def change
    add_column :twittersearches, :retweet, :boolean
  end
end
