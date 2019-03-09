# frozen_string_literal: true

FactoryBot.define do
  factory :chat_attachment do
    chat_message_id { nil }
    attachment_id { 'MyString' }
    filename { 'MyString' }
    url { 'MyString' }
    is_image { false }
    other_params { '' }
  end
end
