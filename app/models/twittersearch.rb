class Twittersearch < ActiveRecord::Base
  belongs_to :user

  has_many :twittertopics
  has_many :twittermbs

	### IN MODEL
	def sentiment(x)
		return Indico.sentiment(x)
	end

	def personality(x)
		return Indico.personality(x)
	end

	def political(x)
		return Indico.political(x)
	end

	###
end
