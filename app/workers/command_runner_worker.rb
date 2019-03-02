# frozen_string_literal: true

# Works on a command
class CommandRunnerWorker < ApplicationWorker
  def perform(params)
    params.symbolize_keys!
    service = DiscordMessageProcessingService.new(params)
    service.run_now
  end
end
