class TwittersearchesController < ApplicationController


	def new
		@user = current_user
		@twittersearch = Twittersearch.new
		@twitter_mb = TwitterMb.new
		@twitter_topic = Twittertopic.new
	end

	def create
		@whosaidit = twittersearch_params[:tweeter]
		@twitteranalysis = ""

		# enabling retweets? will need adjustment
	    if params[:enableRT] == true
	      @RToption = "-RT"
	    else
	      @RToption = ""
	    end

		@tweets = $twitter.search("from:#{@whosaidit}" + " filter:images "+"#{@RToption}").take(30)
		@tweets.each do |tweet|
			@twitteranalysis = @twitteranalysis + tweet.text
		end

		#### calls to indico APIs
		sentiment = Indico.sentiment(@twitteranalysis)
		personality = Indico.personality(@twitteranalysis)
		political = Indico.political(@twitteranalysis)
		####

		@user = current_user
		@twittersearch = Twittersearch.new(user_id: @user.id, tweeter: params[:tweeter], sentiment: sentiment.to_f,  personality_agreeableness: personality["agreeableness"], personality_conscientiousness: personality["conscientiousness"], personality_extraversion: personality["extraversion"], personality_openness: personality["oppenness"], political_conservative: political["conservative"], political_green: political["green"], political_liberal: political["liberal"], political_libertarian: political["libertarian"])
		# runs the creation of the multiple entries associated with the search in the twitter topics table
		@topical.each do |n|
			n.Twittertopic.new(twittersearch_id: @twittersearch.id, topic: n[0], value: n[1].to_f)
			n.Twittertopic.save
		end
		# runs the creation of the multiple entries associated with the search in the twitter myers-briggs table
		@twittermyersbriggs.each do |n|
			n.TwitterMb.new(twittersearch_id: @twittersearch.id, personality_type: n[0], value: n[1].to_f)
			n.TwitterMb.save
		end

	end
end
