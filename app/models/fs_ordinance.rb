class FSOrdinance
	attr_reader :status, :created, :modified, :agent_url, :person, :ordinance

	def initialize( current_user, person, ordinance )
		@current_user = current_user
		name = ordinance['type'].split('/')[-1]
    @ordinance = Ordinance.where( name: name ).first
		@status = ordinance['status'] ? ordinance['status'].split('/')[-1] : nil
		@created = ordinance['attribution'] ? Time.at(ordinance['attribution']['created'] / 1000.0) : nil
		@modified = ordinance['attribution'] ? Time.at(ordinance['attribution']['modified'] / 1000.0) : nil
		@agent_url = ordinance['attribution'] ? ordinance['attribution']['contributor']['resource'] : nil
		@person = person
	end

	def self.from_response( current_user, person, response )
		result = []
		response.body['persons'][0]['ordinances'].each do |ordinance|
			result << FSOrdinance.new( current_user, ordinance )
		end
		return result
	end

	def self.from_reservation( current_user, person, reservations )
		result = []
		reservations.each do |ordinance|
      if ordinance['attribution']
        result << FSOrdinance.new( current_user, person, ordinance )
      end
		end
		return result
	end

	def assigned_contact
		assignment = @current_user.assignments.where( person_id: @person.id, ordinance_id: @ordinance.id )
		return assignment.first if assignment
		return nil
	end
end
