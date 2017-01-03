class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

	private
	def current_user
		#puts "Session is #{session.to_yaml}"
		@current_user ||= User.find_by( id: session[:user_id] )
		puts "current_user is #{@current_user}"
		if @current_user && !@tried_client
			@tried_client = true
			@client = @current_user.client
		end
		if @current_user && @client
			return @current_user
		else
			return nil
		end
	end
	helper_method :current_user

	private def is_logged_in?
		user = current_user()
		puts "User is #{user}"
		return true if user
		return false
	end
	helper_method :is_logged_in?

  private
  # From http://guides.rubyonrails.org/action_controller_overview.html
  # and http://stackoverflow.com/questions/6209663/how-to-skip-a-before-filter-for-devises-sessionscontroller
  def require_login
    puts params[:controller]
    puts "controller is set to: #{controller_name}"
    #unless params[:controller] == 'devise/sessions'
    unless controller_name == 'omniauth_callbacks'
      unless is_logged_in?
        flash[:error] = "You must be logged in to access this content"
        redirect_to root_path # halts request cycle
      end
    end
  end
			###before_filter :require_login

#  private
  # From http://guides.rubyonrails.org/action_controller_overview.html
  # and http://stackoverflow.com/questions/6209663/how-to-skip-a-before-filter-for-devises-sessionscontroller
###  def require_login
###    puts "controller is set to: #{controller_name}"
###    #unless params[:controller] == 'devise/sessions'
###    unless controller_name == 'omniauth_callbacks'
###      unless user_signed_in?
###        flash[:error] = "You must be logged in to access this section"
###        redirect_to portal_login_path # halts request cycle
###      end
###    end
  ###end

end
