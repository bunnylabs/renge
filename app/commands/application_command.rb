# frozen_string_literal: true

# Base command
class ApplicationCommand
  attr_reader :chat_service

  def initialize(chat_service)
    @chat_service = chat_service
  end

  # Does this command only respond to directed commands?
  def directed_only?
    true
  end

  def run; end

  def successful?
    true
  end

  def chat_message
    @chat_service.message
  end
end
