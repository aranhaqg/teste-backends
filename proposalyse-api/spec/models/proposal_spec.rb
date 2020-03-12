require 'rails_helper'

RSpec.describe Proposal, type: :model do
  fixtures :proponents, :proposals, :warranties
  let(:proposal) { proposals(:one) }
  let(:warranties_set) { [Warranty.new] }
  let(:proponents_set) { [proponents(:kevin)] }

  before do
    proposal.proponents = proponents_set
    proposal.warranties = warranties_set
  end

  describe '#loan value' do
    it { should validate_presence_of(:loan_value) }
    it { should validate_numericality_of(:loan_value).is_greater_than(30000) }
    it { should validate_numericality_of(:loan_value).is_less_than(3000000) }
  end

  describe '#number_of_monthly_installments' do
    it { should validate_numericality_of(:number_of_monthly_installments).is_greater_than(24) }
    it { should validate_numericality_of(:number_of_monthly_installments).is_less_than(180) }
  end

  describe '#warranties' do
    context 'when have only no warranties' do
      let(:warranties_set) { [] }

      it { expect(proposal).to_not be_valid }
    end

    context 'when have more than one warranty' do
      let(:warranties_set) { [warranties(:one), warranties(:two)] }

      it { expect(proposal).to_not be_valid }
    end


  end

  describe '#proponents' do
    context 'when have only one proponent' do
      let(:proponents_set) { [proponents(:kate)] }

      it { expect(proposal).to_not be_valid }
    end

    context 'when have two not main proponents' do
      let(:proponents_set) { [proponents(:kate), proponents(:randall)] }

      it { expect(proposal).to_not be_valid }
    end

    context 'when have two main proponents' do
      let(:proponents_set) { [proponents(:kevin), proponents(:tobby)] }

      it { expect(proposal).to_not be_valid }
    end

    context 'when have two proponents, one of them is main' do
      let(:proponents_set) { [proponents(:tobby), proponents(:kate)] }

      it { expect(proposal).to be_valid }
    end
  end
end
