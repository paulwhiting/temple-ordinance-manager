class Contact < ApplicationRecord
  validates :first_nm, presence: true
  validates_format_of :email, with: /@/, allow_blank: true

	has_many :assignments, dependent: :destroy
	has_many :people, through: :assignments

  scope :with_assignments, -> {joins(:assignments)}

	def full_name
    last_nm.blank? ? first_nm : first_nm + ' ' + last_nm
	end

	def last_first_nm
    last_nm.blank? ? first_nm : last_nm + ', ' + first_nm
	end

end
