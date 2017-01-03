class User < ApplicationRecord

	has_many :contacts
	has_many :assignments
	has_many :comments

	def self.from_omniauth( auth_hash )
		user = find_or_create_by( uid: auth_hash['uid'] )
		user.token = auth_hash['credentials']['token']
		user.save!
		return user
	end

	def client
		@client = FamilySearch::Client.new environment: :integration, access_token: token, key: Rails.application.secrets.familysearch_key
		begin
			@client.discover!
		rescue FamilySearch::Error::BadCredentials => e
			@client = nil
		end
		return @client
	end


end
