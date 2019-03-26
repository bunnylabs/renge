# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    chat_source { 'bunnychat' }
    user_key { 'U1234' }
  end
end
