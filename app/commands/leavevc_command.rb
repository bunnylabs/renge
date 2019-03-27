# frozen_string_literal: true

# The Leavevc command
class LeavevcCommand < ApplicationCommand
  def run
    chat_service.leave_voice
    chat_service.reply('Leaving')
  end
end
