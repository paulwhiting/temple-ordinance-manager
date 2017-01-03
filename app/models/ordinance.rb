class Ordinance
	attr_reader :name, :status, :created, :modified, :agent_url, :person

	def initialize( current_user, person, ordinance )
		@current_user = current_user
		@name = ordinance['type'].split('/')[-1]
		@status = ordinance['status'] ? ordinance['status'].split('/')[-1] : nil
		@created = ordinance['attribution'] ? Time.at(ordinance['attribution']['created'] / 1000.0) : nil
		@modified = ordinance['attribution'] ? Time.at(ordinance['attribution']['modified'] / 1000.0) : nil
		@agent_url = ordinance['attribution'] ? ordinance['attribution']['contributor']['resource'] : nil
		@person = person
	end

	def self.from_response( current_user, person, response )
		result = []
		response.body['persons'][0]['ordinances'].each do |ordinance|
			result << Ordinance.new( current_user, ordinance )
		end
		return result
	end

	def self.from_reservation( current_user, person, reservations )
		result = []
		reservations.each do |ordinance|
			result << Ordinance.new( current_user, person, ordinance )
		end
		return result
	end

	def assigned_contact
		assignment = @current_user.assignments.where( person_id: @person.id, ordinance_nm: @name )
		return assignment.first if assignment
		return nil
	end
end
