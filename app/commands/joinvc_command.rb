# frozen_string_literal: true

# The Joinvc command
class JoinvcCommand < ApplicationCommand
  def run
    channel_id = chat_message.command_tokens[0]
    return unless channel_id

    chat_service.join_voice(channel_id)
    chat_service.reply("Joining #{channel_id}")
  end
end
