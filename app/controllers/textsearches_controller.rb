class TextsearchesController < ApplicationController

	def new
		@user = current_user
		@textsearch = Textsearch.new
		@text_mb = TextMb.new
		@text_topic = Texttopic.new
		@text_keyword = Textkeyword.new
	end

	def show
		@user = current_user
		@textsearch = Textsearch.find(params[:id])
	end

	def create
		#define @textanalysis - "params" probably won't work here
		@textanalysis = params[:text_to_analyze].to_s
		@title = params[:title]

		#### calls to indico APIs (future move to library?)
		sentiment = Indico.sentiment(@textanalysis)
		personality = Indico.personality(@textanalysis)
		political = Indico.political(@textanalysis)
		topical = Indico.text_tags(@textanalysis).sort_by {|k,v| v}.reverse.take(10)
		myersbriggs = Indico.personas(@textanalysis).sort_by {|k,v| v}.reverse.take(4)
		keyword = Indico.keywords(@textanalysis).sort_by {|k,v| v}.reverse.take(5)
		####

		@user = current_user
		@textsearch = Textsearch.new(user_id: @user.id, title: @title, sentiment: sentiment.to_f,  personality_agreeableness: personality["agreeableness"], personality_conscientiousness: personality["conscientiousness"], personality_extraversion: personality["extraversion"], personality_openness: personality["openness"], political_conservative: political["Conservative"], political_green: political["Green"], political_liberal: political["Liberal"], political_libertarian: political["Libertarian"])
		@textsearch.save
		# runs the creation of the multiple entries associated with the search in the text topics table
		topical.each do |n|
			@texttopic = Texttopic.new(textsearch_id: @textsearch.id, topic: n[0], value: n[1].to_f)
			@texttopic.save
		end
		# runs the creation of the multiple entries associated with the search in the text myers-briggs table
		myersbriggs.each do |n|
			@textmb = TextMb.new(textsearch_id: @textsearch.id, personality_type: n[0], value: n[1])
			@textmb.save
		end
		# runs the creation of the multiple entries associated with the search in the text keywords table
		keyword.each do |n|
			@textkeyword = Textkeyword.new(textsearch_id: @textsearch.id, keyword: n[0], value: n[1])
			@textkeyword.save
		end

		redirect_to root_path
	end

	private
	def textsearch_params
		params.require(:textsearch).permit(:user_id, :character_length, :sentiment, :personality_agreeableness, :personality_conscientiousness, :personality_extraversion, :personality_openness, :political_conservative, :political_green, :political_liberal, :political_libertarian)
	end
end
