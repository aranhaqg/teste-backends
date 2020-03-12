class Proposal < ApplicationRecord
  has_many :proponents
  has_many :warranties

  validates :loan_value, presence: :true, numericality: { greater_than: 30000, less_than: 3000000 }
end
