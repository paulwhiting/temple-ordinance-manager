class Person
	attr_reader :name, :id, :debug, :links, :reservations

	def initialize( current_user, person_id, reservations )
		@current_user = current_user
		client = @current_user.client
		r = client.template('person').get pid: person_id
		person = r.body['persons'][0]
		@debug = person.to_yaml
		@links = person['links']
		@name = person['display']['name']
		@id = person['id']
		@reservations = FSOrdinance.from_reservation( @current_user, self, reservations )
	end

	#def ordinances
		#return @ordinances if @ordinances
		#@ordinances = Ordinance.from_response(@current_user.client.get(@links['ordinances']['href']))
	#end

	#def reservations
		#return @reservations if @reservations
		##@reservations = @current_user.client.get(@links['ordinance-reservations']['href']).to_yaml
	#end

	def comment
		return @comment if @comment
		comments = @current_user.comments.where( person_id: @id ).first
		@comment = comments ? comments.comments : nil
	end

	def self.from_response( current_user, reservations_response )
		result = []
		reservations_response.body['persons'].each do |person_ord|
			result << Person.new( current_user, person_ord['id'], person_ord['ordinances'] )
		end
		return result
	end
end
