require 'rails_helper'

RSpec.describe Proposal, type: :model do
  fixtures :proponents, :proposals, :warranties
  let(:proposal) { proposals(:proposal_one) }
  let(:warranties_set) { [warranties(:warranty_one), warranties(:warranty_tree)] }
  let(:proponents_set) { [proponents(:kevin), proponents(:kate)] }

  before do
    proposal.proponents = proponents_set
    proposal.warranties = warranties_set
  end


  subject { proposal }
  describe '#warranties' do

    context 'when have less then one warranty' do
      let(:warranties_set) { [] }

      it { expect(proposal).to_not be_valid }
    end

    context 'when have more than one warranty and their sum of their values' do
      context 'is less than loan value' do
        let(:warranties_set) { [warranties(:warranty_one), warranties(:warranty_two)] }

        it { expect(proposal).to_not be_valid }
      end

      context 'is more or equals loan value' do
        let(:warranties_set) { [warranties(:warranty_one), warranties(:warranty_tree)] }

        it { expect(proposal).to be_valid }
      end
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
