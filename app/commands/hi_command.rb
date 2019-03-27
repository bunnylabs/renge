# frozen_string_literal: true

# The hi command
class HiCommand < ApplicationCommand
  def public?
    true
  end

  def divine?
    false
  end

  def run
    player = Player.find_by(player_signature)

    return chat_service.reply("Hello, #{author_username}!") if player

    Player.create(player_signature)
    chat_service.reply("Nice to meet you, #{author_username}!")
  end

  private

  def player_signature
    {
      chat_source: chat_message.chat_source,
      user_key: chat_message.author_key
    }
  end

  def author_username
    chat_message.author_username
  end
end
