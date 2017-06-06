class Ordinance < ApplicationRecord
	belongs_to :assignment
  scope :baptism, -> {where(id: 1)}
  scope :confirmation, -> {where(id: 2)}
  scope :initiatory, -> {where(id: 3)}
  scope :endowment, -> {where(id: 4)}
  scope :sealing_child_to_parent, -> {where(id: 5)}
  scope :sealing_to_spouse, -> {where(id: 6)}
end
