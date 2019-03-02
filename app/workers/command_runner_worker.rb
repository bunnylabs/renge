# frozen_string_literal: true

# Works on a command
class CommandRunnerWorker < ApplicationWorker
  def perform(params)
    params.symbolize_keys!
    service = DiscordMessageProcessingService.new(params)
    cmd = service.command_class.new(params, service)
    cmd.run
  end
end
