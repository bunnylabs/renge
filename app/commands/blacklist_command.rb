# frozen_string_literal: true

# The Blacklist command
class BlacklistCommand < ApplicationCommand
  def run
    user_id = chat_message.command_tokens[0]
    return unless user_id

    player = Player.find_or_create_by(user_key: user_id)
    BlacklistEntry.create(player: player)
  end
end
