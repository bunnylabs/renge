# frozen_string_literal: true

# Base command
class ApplicationCommand
  def initialize(params, message_info)
    @params = params
    @message_info = message_info
  end

  # Does this command only responds to directed commands?
  def directed_only?
    true
  end

  def author_id
    @params[:author_id]
  end

  def room_id
    @params[:room_id]
  end

  def reply(msg)
    DiscordService.send_message(room_id, msg)
  end

  def run; end

  delegate :message, to: :message_info

  private

  attr_reader :message_info
end
