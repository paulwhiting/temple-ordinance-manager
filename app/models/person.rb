class Person < ApplicationRecord
  validates :fs_pid, presence: true
  validates :name, presence: true

  has_one :comment
	#attr_reader :name, :id, :debug, :links, :reservations
  attr_accessor :reservations, :current_user

	#def self.fs_initialize( current_user, person_id, reservations )
		#@current_user = current_user
		#client = @current_user.client
		#r = client.template('person').get pid: person_id
		#person = r.body['persons'][0]
		#@debug = person.to_yaml
		#@links = person['links']
		#@name = person['display']['name']
		#@id = person['id']
		#@reservations = FSOrdinance.from_reservation( @current_user, self, reservations )
	#end

	#def ordinances
		#return @ordinances if @ordinances
		#@ordinances = Ordinance.from_response(@current_user.client.get(@links['ordinances']['href']))
	#end

	#def reservations
		#return @reservations if @reservations
		##@reservations = @current_user.client.get(@links['ordinance-reservations']['href']).to_yaml
	#end

	#def comment
		#return @comment if @comment
		#comments = @current_user.comments.where( person_id: @id ).first
		#@comment = comments ? comments.comments : nil
	#end

	def self.from_response( current_user, reservations_response )
		result = []
		reservations_response.body['persons'].each do |person_ord|
      person_id = person_ord['id']
      p = current_user.people.where(fs_pid: person_id).first_or_create do |person|
        r = current_user.client.template('person').get pid: person_id
        fs_person = r.body['persons'][0]
        person.name = fs_person['display']['name']
        person.save!
      end
      p.current_user = current_user
      reservations = person_ord['ordinances']
      p.reservations = FSOrdinance.from_reservation( current_user, p, reservations )
      result << p
		end
		return result
	end
end
