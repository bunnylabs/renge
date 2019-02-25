# frozen_string_literal: true

# This class processes messages from discord
class DiscordMessageProcessingService
  def initializer(_params)
    @result = :ok
  end

  attr_reader :result
end
