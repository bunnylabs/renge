# frozen_string_literal: true

require 'net/http'

# Abstract chat service
class ApplicationChatService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def send_message(chan, msg); end

  def reply(reply_message)
    send_message(message.room_key, reply_message)
  end
end
