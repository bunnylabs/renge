# frozen_string_literal: true

# Methods to assist with parsing a message
module CommandParsimony
  extend ActiveSupport::Concern

  def directed?
    room_type == 'dm' || starts_with_username?
  end

  def starts_with_username?
    raw_tokens[0] == "<@#{bot_id}>" || raw_tokens[0] == bot_username
  end

  def raw_tokens
    message.split(' ')
  end

  def tokens
    return raw_tokens[1..-1] if starts_with_username?

    raw_tokens
  end

  def command_tokens
    tokens.join(' ')
  end

  def command
    tokens[0] || ''
  end

  def command_class
    "#{command.camelize}Command".safe_constantize
  end

  def chat_service_prefix
    chat_source.camelize
  end

  def chat_service_class
    "#{chat_service_prefix}::ChatService".safe_constantize
  end

  def processable?
    evaluation == :ok
  end

  def evaluation
    no_such_command? ||
      own_message? ||
      unknown_source? ||
      not_directed? ||
      :ok
  end

  def no_such_command?
    :no_such_command if command_class.nil?
  end

  def own_message?
    :own_message if author_id == bot_id
  end

  def unknown_source?
    :unknown_source if chat_service_class.nil?
  end

  def not_directed?
    :not_directed if command_class&.new(nil)&.directed_only? && !directed?
  end
end
