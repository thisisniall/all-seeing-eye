class HomeController < ApplicationController
  def index
  	puts "HI"


  	puts "END"
  end


  def search
  	@query = params[:query]
  	@tweets = $twitter.search(@query+" filter:images").take(20)
  
  	puts @tweets.first.inspect


  	render "index"
  end
end
