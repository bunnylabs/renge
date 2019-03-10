# frozen_string_literal: true

module Slack
  # This class processes messages from discord
  class ChatService < ApplicationChatService
    def send_message(chan, msg)
      client = Slack::Web::Client.new
      client.chat_postMessage(channel: chan, text: msg, as_user: true)
    end
  end
end
