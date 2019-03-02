# frozen_string_literal: true

# This class processes messages from discord
class DiscordMessageProcessingService
  attr_reader :result

  def initialize(params)
    @result = :not_run
    @params = params
  end

  def run
    return unless @result == :not_run

    return @result = :self if @params[:author_id].to_s == DiscordService.id.to_s
    return @result = :ignored if no_such_command

    cmd = command_class.new(@params, self)
    cmd.run if directed? == cmd.directed_only?
    @result = :ok
  end

  def directed?
    @params[:room_type] == 'dm' || raw_tokens[0] == "<@#{DiscordService.id}>"
  end

  def raw_tokens
    @params[:message].split(' ')
  end

  def tokens
    return raw_tokens[1..-1] if raw_tokens[0] == "<@#{DiscordService.id}>"

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
end
