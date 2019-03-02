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
    return @result = :not_understood if no_such_command

    cmd = command_class.new(@params, self)
    return @result = :ignored unless directed? == cmd.directed_only?

    CommandRunnerWorker.perform_async(@params)
    @result = :ok
  end

  def directed?
    @params[:room_type] == 'dm' || starts_with_username
  end

  def starts_with_username
    raw_tokens[0] == "<@#{DiscordService.id}>" ||
      raw_tokens[0] == DiscordService.username
  end

  def raw_tokens
    @params[:message].split(' ')
  end

  def tokens
    return raw_tokens[1..-1] if starts_with_username

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
