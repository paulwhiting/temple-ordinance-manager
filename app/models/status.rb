class Status < ApplicationRecord

  scope :complete, -> {where(name: 'Completed')}

  def reservable?
    return name == 'Ready'
  end

  # not reserved by user, not reservable, not complete
  def invalid?
    good_ones = ['Ready','Submittable','Completed','Resubmittable','InProgress']
    return !good_ones.include?(name)
  end
end
