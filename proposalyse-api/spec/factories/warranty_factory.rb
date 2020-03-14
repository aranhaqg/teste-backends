# frozen_string_literal: true

FactoryBot.define do
  factory :warranty do
    sequence(:id_hash) { |n| "0HASH#{n}" }
    value { 10_000.00 }
    province { 'CE' }
    proposal
  end
end
