class HomeController < ApplicationController
  def index
    if current_user
      @user = current_user
      @twittersearch = Twittersearch.new
      @textsearch = Textsearch.new
    else
      redirect_to log_in_path
    end
  end

  #additional whosaidit parameter for search by user

  def search
  	@whosaidit = params[:whosaidit]
  	@query = params[:query]

    if params[:enableRT] == true
      @RToption = "-RT"
    else
      @RToption = ""
    end

  	# user and keyword
  	# @tweets = $twitter.search("to:#{@whosaidit} "+ @query + " filter:images").take(20)

  	# just keyword
  	# @tweets = $twitter.search(@query + " filter:images").take(20)

  	# just user
  	@tweets = $twitter.search("from:#{@whosaidit}" + " filter:images "+"#{@RToption}").take(30)
  
  	# puts @tweets.first.inspect
  	@twitteranalysis = ""
  	render "index"
  end

  def analyze
    @analyzetext = params[:text_to_analyze].to_s
    render "index"
  end

end
