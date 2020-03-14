
class Proponent < ApplicationRecord
  belongs_to :proposal
  validates :age, numericality: { greater_than_or_equal_to: 18 }
end
