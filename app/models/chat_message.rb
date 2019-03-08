# frozen_string_literal: true

# Represents a chat message
class ChatMessage < ApplicationRecord
  include CommandParsimony

  has_many :chat_attachments
  accepts_nested_attributes_for :chat_attachments
end
