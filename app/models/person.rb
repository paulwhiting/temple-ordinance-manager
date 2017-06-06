class Person < ApplicationRecord
  validates :fs_pid, presence: true
  validates :name, presence: true

  has_one :comment
  has_many :assignments
  has_many :ordinances, through: :assignments
  attr_accessor :reservations, :current_user

  scope :needs_baptism, -> {joins(:assignments).merge(Assignment.baptism.incomplete)}
  scope :needs_confirmation, -> {joins(:assignments).merge(Assignment.confirmation.incomplete)}
  scope :needs_initiatory, -> {joins(:assignments).merge(Assignment.initiatory.incomplete)}
  scope :needs_endowment, -> {joins(:assignments).merge(Assignment.endowment.incomplete)}

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

  #def reservations
    #return @reservations if @reservations
    ##@reservations = @current_user.client.get(@links['ordinance-reservations']['href']).to_yaml
  #end

  def next_reserved_ordinance
    return reservations.min if reservations
    return nil
  end

  def self.from_response( current_user, reservations_response )
    result = []
    if reservations_response.body # make sure we didn't get a 204 response
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
    end
    return result
  end
end
