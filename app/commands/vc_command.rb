# frozen_string_literal: true

# The Vc command
class VcCommand < ApplicationCommand
  def directed_only?
    false
  end

  def public?
    false
  end

  def divine?
    false
  end

  def run
    return unless chat_service.is_a? Discord::ChatService

    message = chat_message.command_tokens.join(' ')
    return if message.length.zero?

    unless chat_service.in_voice_channel?
      return chat_service.reply(
        'You must be in the voice channel with me to use this command'
      )
    end

    chat_service.say_voice(message, seiyuu.name)
  end

  private

  def seiyuu
    chat_message.author.seiyuu || 'Matthew'
  end
end
