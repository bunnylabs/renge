# frozen_string_literal: true

# Works on a command
class CommandRunnerWorker < ApplicationWorker
  def perform(info)
    message = ChatMessage.find(info.symbolize_keys[:message_id])

    service = message.chat_service_class.new(message)
    command = message.command_class.new(service)
    command.run

    message.processed = command.successful?
    message.save!
  end
end
