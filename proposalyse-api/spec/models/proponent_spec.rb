require 'rails_helper'

RSpec.describe Proponent, type: :model do
  describe '#age' do
    it { should validate_numericality_of(:age).is_greater_than(18) }
  end
end
