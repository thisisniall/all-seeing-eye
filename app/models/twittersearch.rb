class Twittersearch < ActiveRecord::Base
  belongs_to :user

  has_many :twittertopics
  has_many :twitter_mbs

end
