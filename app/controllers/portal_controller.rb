class PortalController < ApplicationController
  skip_before_action :require_login, :only => [:index]

	def index
    if current_user
			@people = []
			begin
				response = current_user.client.get("/platform/reservations/users/#{current_user.uid}")
				@people = Person.from_response( current_user, response )
			rescue FamilySearch::Error::ClientError
				#people = []
			end
      @people.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    end
	end

end
