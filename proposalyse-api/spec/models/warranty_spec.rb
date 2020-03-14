require 'rails_helper'

RSpec.describe Warranty, type: :model do
  describe '#province' do
    it { should validate_numericality_of(:age).is_greater_than(18) }
  end
end
