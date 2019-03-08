# frozen_string_literal: true

# The Echo command
class EchoCommand < ApplicationCommand
  def zero_width_space
    '​'
  end

  def safe_triple_backtick
    "`#{zero_width_space}`#{zero_width_space}`"
  end

  def quoted
    chat_message.message.inspect
  end

  def escaped_quoted_string
    quoted.gsub('```', safe_triple_backtick)
  end

  def run
    chat_service.reply("```\n#{escaped_quoted_string}\n```")
  end
end
