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

	    # cycles through text of various tweets, compiles them into a single string for analysis
		@tweets = $twitter.search("from:#{@whosaidit}" + " filter:images "+"#{@RToption}").take(30)
		@tweets.each do |tweet|
			@twitteranalysis = @twitteranalysis + tweet.text
		end

		#### calls to indico APIs (future move to library?)
		sentiment = Indico.sentiment(@twitteranalysis)
		personality = Indico.personality(@twitteranalysis)
		political = Indico.political(@twitteranalysis)
		topical = Indico.text_tags(@twitteranalysis).sort_by {|k,v| v}.reverse.take(10)
		myersbriggs = Indico.personas(@twitteranalysis).sort_by {|k,v| v}.reverse.take(4)
		####

		@user = current_user
		@twittersearch = Twittersearch.new(user_id: @user.id, tweeter: params[:twittersearch][:tweeter], sentiment: sentiment.to_f,  personality_agreeableness: personality["agreeableness"], personality_conscientiousness: personality["conscientiousness"], personality_extraversion: personality["extraversion"], personality_openness: personality["openness"], political_conservative: political["Conservative"], political_green: political["Green"], political_liberal: political["Liberal"], political_libertarian: political["Libertarian"])
		@twittersearch.save
		# runs the creation of the multiple entries associated with the search in the twitter topics table
		topical.each do |n|
			@twittertopic = Twittertopic.new(twittersearch_id: @twittersearch.id, topic: n[0], value: n[1].to_f)
			@twittertopic.save
		end
		# runs the creation of the multiple entries associated with the search in the twitter myers-briggs table
		myersbriggs.each do |n|
			@twittermb = TwitterMb.new(twittersearch_id: @twittersearch.id, personality_type: n[0], value: n[1])
			@twittermb.save
		end

		redirect_to root_path
	end

	private
	def twittersearch_params
		params.require(:twittersearch).permit(:user_id, :tweeter, :retweet, :sentiment, :personality_agreeableness, :personality_conscientiousness, :personality_extraversion, :personality_openness, :political_conservative, :political_green, :political_liberal, :political_libertarian)
	end

end
