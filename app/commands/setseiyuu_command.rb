# frozen_string_literal: true

# The Setseiyuu command
class SetseiyuuCommand < ApplicationCommand
  def divine?
    false
  end

  def public?
    false
  end

  def run
    unless seiyuu
      return chat_service.reply(<<~EDUCATE)
        You need to use the name of a valid seiyuu. Valid names are:
        #{Seiyuu.pluck(:name).join(', ')}
      EDUCATE
    end

    chat_message.author.seiyuu = seiyuu

    chat_service.say_voice(<<-MSG, seiyuu.name)
        This is what #{chat_message.author_username} sounds like now"
    MSG
    chat_service.reply("#{id}, your seiyuu is set to #{seiyuu.name}")
  end

  private

  def seiyuu
    name = chat_message.command_tokens.join(' ')
    Seiyuu.find_by('name ILIKE ?', name)
  end

  def id
    "<@#{chat_message.author_key}>"
  end
end
