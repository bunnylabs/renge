# frozen_string_literal: true

# The Hi command
class HiCommand < ApplicationCommand
  def run
    reply("Hi, you said `#{message.inspect}`")
  end
end
