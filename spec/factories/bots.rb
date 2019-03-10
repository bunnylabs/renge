# frozen_string_literal: true

FactoryBot.define do
  factory :bot do
    player { nil }
    bot_password { 'MyString' }
    response_auth_document { '' }
  end
end
