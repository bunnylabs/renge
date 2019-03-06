# frozen_string_literal: true

# Provides functions to interpret a discord message
class DiscordMessageService
  def initialize(params)
    @params = params
  end

  def directed?
    @params[:room_type] == 'dm' || starts_with_username?
  end

  def starts_with_username?
    raw_tokens[0] == "<@#{DiscordService.id}>" ||
      raw_tokens[0] == DiscordService.username
  end

  def raw_tokens
    @params[:message].split(' ')
  end

  def tokens
    return raw_tokens[1..-1] if starts_with_username?

    raw_tokens
  end

  def raw_message
    @params[:message]
  end

  def message
    tokens.join(' ')
  end

  def command
    tokens[0]
  end

  def command_class
    "#{command.camelize}Command".safe_constantize
  end

  def no_such_command
    command_class.nil?
  end

  def author_id
    @params[:author_id].to_s
  end

  def room_id
    @params[:room_id].to_s
  end

  def reply(msg)
    DiscordService.send_message(room_id, msg)
  end
end
