require 'rails_helper'

RSpec.describe Proposal, type: :model do
  let(:proposal) { build(:proposal) }

  describe '#warranties' do
    context 'when have less then one warranty' do
      before { proposal.warranties = [] }
      it { expect(proposal).to_not be_valid }
    end

    context 'when have more than one warranty' do
      context 'and the sum of their values is less than loan value' do
        before { proposal.warranties = [build(:warranty)] }
        it { expect(proposal).to_not be_valid }
      end

      context 'and the sum of their values is more or equals loan value' do
        it { expect(proposal).to be_valid }
      end

      context 'and any of them belong to province PR, SC or RS' do
        before { proposal.warranties = [build(:warranty, province: 'PR')] }
        it { expect(proposal).to_not be_valid }
      end
    end
  end

  describe '#proponents' do
    context 'when have only one proponent' do
      before do
        proposal.proponents = [build(:proponent)]
      end
      it { expect(proposal).to_not be_valid }
    end

    context 'when have two not main proponents' do
      before do
        proposal.proponents = build_list(:proponent, 2, is_main: false)
      end
      it { expect(proposal).to_not be_valid }
    end

    context 'when have two main proponents' do
      before do
        proposal.proponents = build_list(:proponent, 2)
      end

      it { expect(proposal).to_not be_valid }
    end

    context 'when have two proponents, one of them is the main' do
      context 'and age between 18 and 24 years' do
        let(:monthly_income_limit) { 4 * proposal.installment_value }

        context 'monthly_income is 4 times loan instalment value' do
          before do
            proposal.main_proponent.monthly_income = monthly_income_limit
          end
          it { expect(proposal).to be_valid }
        end

        context 'monthly_income less than 4 times loan instalment value' do
          before { proposal.main_proponent.monthly_income = 1 }
          it { expect(proposal).to_not be_valid }
        end
      end

      context 'and age between 24 and 50 years' do
        before { proposal.main_proponent.age = 50 }
        let(:monthly_income_limit) { 3 * proposal.installment_value }

        context 'monthly_income is 3 times loan instalment
        value' do
          before do
            proposal.main_proponent.monthly_income = monthly_income_limit
          end
          it { expect(proposal).to be_valid }
        end

        context 'monthly_income less than 3 times loan instalment value' do
          before do
            proposal.main_proponent.monthly_income = monthly_income_limit - 1
          end

          it { expect(proposal).to_not be_valid }
        end
      end

      context 'and greater than 50 years' do
        let(:monthly_income_limit) { 2 * proposal.installment_value }
        before { proposal.main_proponent.age = 51 }
        context 'monthly_income is 2 times loan instalment
        value' do
          before do
            proposal.main_proponent.monthly_income = monthly_income_limit
          end
          it { expect(proposal).to be_valid }
        end

        context 'monthly_income less than 2 times loan instalment value' do
          before do
            proposal.main_proponent.monthly_income = monthly_income_limit - 1
          end
          it { expect(proposal).to_not be_valid }
        end
      end
      # it { expect(proposal).to be_valid }
    end
  end
end
