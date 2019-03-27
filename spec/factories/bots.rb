# frozen_string_literal: true

FactoryBot.define do
  factory :bot do
    bot_password { 'MyString' }
    active { true }
    response_auth_document { '{}' }
  end
end
