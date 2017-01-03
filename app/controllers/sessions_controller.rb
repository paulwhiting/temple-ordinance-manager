class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:create]
	def create
		begin
			@user = User.from_omniauth(request.env['omniauth.auth'])
			session[:user_id] = @user.id
			flash[:success] = "Welcome, #{@user.name}"
		rescue
			flash[:warning] = "There was an unexpected error while trying to authenticate you..."
		end
		redirect_to root_path
	end

	def destroy
		if current_user
			session.delete(:user_id)
		end
		redirect_to root_path
	end
end
