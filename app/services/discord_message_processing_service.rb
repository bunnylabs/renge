# frozen_string_literal: true

# This class processes messages from discord
class DiscordMessageProcessingService < DiscordMessageService
  attr_reader :result

  def initialize(params)
    @result = :not_run
    super
  end

  def run
    run_if_valid do
      # Push the command to the queue to be run
      CommandRunnerWorker.perform_async(@params)
    end
  end

  def run_now
    run_if_valid do
      # Perform the command immediately
      cmd = command_class.new(@params)
      cmd.run
    end
  end

  private

  def run_if_valid(&block)
    return unless @result == :not_run

    return @result = :self if author_id == DiscordService.id.to_s
    return @result = :not_understood if no_such_command

    cmd = command_class.new(@params)
    return @result = :ignored unless directed? == cmd.directed_only?

    yield if block
    @result = :ok
  end
end
