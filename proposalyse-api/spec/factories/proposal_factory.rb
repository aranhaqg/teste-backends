# frozen_string_literal: true

FactoryBot.define do
  factory :proposal do
    sequence(:id_hash) { |n| "0HASH#{n}" }
    loan_value { 30_000.00 }
    number_of_monthly_installments { 100 }

    after(:build) do |proposal|
      proposal.proponents << build(:proponent, is_main: true, proposal: proposal)
      proposal.proponents << build(:proponent, is_main: false, proposal: proposal)
      proposal.warranties << build_list(:warranty, 3, proposal: proposal)
    end
  end
end
