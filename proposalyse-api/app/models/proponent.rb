class Proponent < ApplicationRecord

  validates :age, numericality: { greater_than: 18 }
end
