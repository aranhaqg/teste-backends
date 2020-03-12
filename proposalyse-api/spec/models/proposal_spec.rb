require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe '#loan value' do
    it { should validate_presence_of(:loan_value) }
    it { should validate_numericality_of(:loan_value).is_greater_than(30000) }
    it { should validate_numericality_of(:loan_value).is_less_than(3000000) }
  end
end
