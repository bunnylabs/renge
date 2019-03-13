# frozen_string_literal: true

FactoryBot.define do
  factory :bot do
    bot_password { 'MyString' }
    active { false }
    response_auth_document { '' }
  end
end
