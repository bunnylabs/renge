# frozen_string_literal: true

# Methods to assist with parsing a message
module CommandParser
  extend ActiveSupport::Concern

  def directed?
    room_type == 'dm' || starts_with_username?
  end

  def starts_with_username?
    raw_tokens[0] == "<@#{bot_key}>" || raw_tokens[0] == bot_username
  end

  def raw_tokens
    message.split(' ')
  end

  def tokens
    return raw_tokens[1..-1] if starts_with_username?

    raw_tokens
  end

  def command_tokens
    tokens[1..-1]
  end

  def command
    tokens[0].sub(/:$/, '') || ''
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

  def factors
    %i[
      bot_unknown
      own_message
      unknown_source
      not_directed
      no_such_command
      author_blacklisted
      author_is_mortal
      author_is_stranger
    ]
  end

  def evaluation
    result = nil
    factors.each { |factor| result ||= send(:"#{factor}?") ? factor : nil }
    result ||= :ok
  end

  def no_such_command?
    command_class.nil?
  end

  def own_message?
    author_key == bot_key
  end

  def unknown_source?
    chat_service_class.nil?
  end

  def not_directed?
    command_class&.new(nil)&.directed_only? && !directed?
  end

  def author_blacklisted?
    author.present? && author.blacklisted?
  end

  def bot_unknown?
    bot.nil?
  end

  def author_is_mortal?
    return false unless command_class&.new(nil)&.divine?
    return true unless author.present?

    !author.god.present?
  end

  def author_is_stranger?
    return false if command_class&.new(nil)&.public?

    !author.present?
  end
end
