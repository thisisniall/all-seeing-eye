class User < ActiveRecord::Base
	has_secure_password
	# make sure you can't use an email that's already been taken
	validates_uniqueness_of :email, on: :create
	# for use with creating a user, makes sure you enter the email twice
	validates_confirmation_of :email, on: :create
	
	#standard roll-your-own authentication with bcrypt
	validates_confirmation_of :password
	validates_presence_of :password, on: :create

end
