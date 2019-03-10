# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    chat_source { 'MyString' }
    user_id { 'MyString' }
  end
end
