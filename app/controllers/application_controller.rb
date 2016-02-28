class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # for running indico
  Indico.api_key = 'ff667312b4808d831f194a6a620053f8'


 # global methods for use throughout the application
 	helper_method :current_user

	def current_user
		# checks to see if session exists, if so, loads user
		# and saves into @user instance variable
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def time_ago_in_words(from_time)
		distance_of_time_in_words(from_time, Time.now)
	end


end
