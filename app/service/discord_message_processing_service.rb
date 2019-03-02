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

    if @params[:author_id].to_s == DiscordService.id.to_s
      @result = :self
      return
    end

    DiscordService.send_message(@params[:room_id], "Hi, you said `#{@params[:message].inspect}`")
    @result = :ok
  end
end
