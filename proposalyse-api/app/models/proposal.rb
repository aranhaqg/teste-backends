class Proposal < ApplicationRecord
  has_many :proponents
  has_many :warranties
  accepts_nested_attributes_for :proponents, :warranties

  validates :loan_value,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 30_000.0,
              less_than_or_equal_to: 300_0000.0
            }
  validates :proponents, length: {minimum: 2}
  validates :warranties, length: {minimum: 1}
  validates :number_of_monthly_installments,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 24,
              less_than_or_equal_to: 180
            }

  validate :validate_main_proponent,
           :validade_proponents_age,
           :validate_warranties_value_sum,
           :validate_warranties_province

  def installment_value
    loan_value/number_of_monthly_installments
  end

  def main_proponent
    proponents.select { |p| p.is_main == true }.first
  end

  private

  def validate_main_proponent
    main_proponents_count = proponents.select{ |p| p.is_main == true }.count

    return errors.add(:proponents, 'can only have 1 main proponent') if main_proponents_count != 1
    if main_proponent.age.between?(18,24) && main_proponent.monthly_income < 4 * installment_value
      return errors.add(:proponents, "Proponent must have at least a monthly income equals #{4 * installment_value}")
    elsif main_proponent.age.between?(24,50) && main_proponent.monthly_income < 3 * installment_value
      return errors.add(:proponents, "Proponent must have at least a monthly income equals #{3 * installment_value}")
    elsif main_proponent.age > 50 && main_proponent.monthly_income < 2 * installment_value
      return errors.add(:proponents, "Proponent must have at least a monthly income equals #{2 * installment_value}" )
    end
  end

  def validade_proponents_age
    errors.add(:proponents, 'It cannot have under 18 proponent') if proponents.where('age < 18').count > 1
  end

  def validate_warranties_value_sum
    errors.add(:warranties) if warranties.sum(&:value) < loan_value
  end

  def validate_warranties_province
    errors.add(:warranties) if warranties.where(province: ['PR', 'SC', 'RS']).count > 0
  end
end
