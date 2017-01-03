class Contact < ApplicationRecord
	has_many :assignments

	def full_name
		first_nm + ' ' + last_nm
	end

	def last_first_nm
		last_nm + ', ' + first_nm
	end

end
