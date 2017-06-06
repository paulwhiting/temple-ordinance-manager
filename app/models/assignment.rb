class Assignment < ApplicationRecord
	belongs_to :user
  belongs_to :person
  belongs_to :ordinance
  belongs_to :status, optional: true
	belongs_to :contact

  scope :incomplete, -> {joins('LEFT JOIN statuses on assignments.status_id = statuses.id').where( 'statuses.name is null or statuses.name != "Completed"' )}
  scope :complete, -> {joins(:status).merge(Status.complete)}
  scope :baptism, -> {joins(:ordinance).merge(Ordinance.baptism)}
  scope :confirmation, -> {joins(:ordinance).merge(Ordinance.confirmation)}
  scope :initiatory, -> {joins(:ordinance).merge(Ordinance.initiatory)}
  scope :endowment, -> {joins(:ordinance).merge(Ordinance.endowment)}

  # given one assignment find all the related ones
  def related
    Assignment.where(user_id: user_id, contact_id: contact_id, person_id: person_id)
  end
end
