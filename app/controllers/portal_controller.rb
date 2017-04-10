class PortalController < ApplicationController
  skip_before_action :require_login, :only => [:index]

  def index
    if current_user
      @people = []
      @clienterror = false
      begin
        response = current_user.client.get("/platform/reservations/users/#{current_user.uid}?count=10000")
        @people = Person.from_response( current_user, response )
      rescue FamilySearch::Error::ClientError
        @clienterror = true
      end
      @people.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    end
  end

  def debug
    if current_user
      begin
        response = current_user.client.get("/platform/reservations/users/#{current_user.uid}?count=10000")
        render plain: response.to_yaml
      rescue FamilySearch::Error::ClientError => e
        response = "An error happened.  That's all I know."
        render plain: response + e.to_yaml
      end
    end
  end

end
