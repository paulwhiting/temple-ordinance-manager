class Assignment < ApplicationRecord
	belongs_to :user
	belongs_to :contact
  belongs_to :ordinance
  belongs_to :status, optional: true


  scope :incomplete, -> {joins('LEFT JOIN statuses on assignments.status_id = statuses.id').where( 'statuses.name is null or statuses.name = "Completed"' )}

  #scope :related, Assignment.where(user_id: user_id, contact_id: contact_id, person_id: person_id)
  def related
    Assignment.where(user_id: user_id, contact_id: contact_id, person_id: person_id)
  end
end
