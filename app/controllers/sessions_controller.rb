class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.where(email: params[:email]).first
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			flash[:notice] = "You've been signed in!"
			redirect_to '/'
		else
			flash[:alert] = "Username and password do not match our records."
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		current_user = nil
		flash[:notice] = "You've logged out."
		redirect_to log_in_path
	end
end
