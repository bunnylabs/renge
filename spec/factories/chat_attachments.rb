# frozen_string_literal: true

FactoryBot.define do
  factory :chat_attachment do
    chat_message
    attachment_key { 'MyString' }
    filename { 'MyString' }
    url { 'http://example.com/image' }
    is_image { true }
    other_params { '{}' }
  end
end
