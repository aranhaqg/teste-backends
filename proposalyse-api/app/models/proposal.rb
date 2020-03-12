class Proposal < ApplicationRecord
  has_many :proponents
  has_many :warranties

  validates :loan_value, presence: :true, numericality: { greater_than: 30000, less_than: 3000000 }
  validates :proponents, length: {minimum: 2}
  validates :warranties, length: {minimum: 1}
  validates :number_of_monthly_installments, presence: :true, numericality: {greater_than: 24, less_than: 180}

  validate :main_proponent_existence

  private

  def main_proponent_existence
    errors.add(:proponents) if proponents.where(is_main: true).count != 1
  end
end
