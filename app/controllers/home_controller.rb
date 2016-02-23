class HomeController < ApplicationController
  def index
  end

  #additional whosaidit parameter for search by user

  def search
  	@whosaidit = params[:whosaidit]
  	@query = params[:query]

  	# user and keyword
  	# @tweets = $twitter.search("to:#{@whosaidit} "+ @query + " filter:images").take(20)

  	# just keyword
  	# @tweets = $twitter.search(@query + " filter:images").take(20)

  	# just user
  	@tweets = $twitter.search("from:#{@whosaidit}" + " filter:images").take(20)
  
  	# puts @tweets.first.inspect
  	@foranalysis = ""
  	render "index"

  end
end
