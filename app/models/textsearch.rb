class Textsearch < ActiveRecord::Base
  belongs_to :user

  has_many :texttopics
  has_many :text_mbs
  has_many :textkeywords
end
