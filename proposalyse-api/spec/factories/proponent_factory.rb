# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    sequence(:id_hash) { |n| "0HASH#{n}" }
    name { 'John' }
    monthly_income { 2_000.00 }
    age { 18 }
    is_main { true }
    proposal
  end
end
