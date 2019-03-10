# frozen_string_literal: true

# Represents an attachment to a chat message
class ChatAttachment < ApplicationRecord
  ulid :chat_message_id
  belongs_to :chat_message

  validates_presence_of :chat_message
end
