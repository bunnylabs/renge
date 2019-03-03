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
      cmd.run
    end
  end

  def already_run?
    @result == :not_run
  end

  def own_message?
    author_id == DiscordService.id.to_s
  end

  def will_read?
    return true unless cmd.directed_only?

    directed?
  end

  def cmd
    @cmd ||= command_class.new(@params)
  end

  private

  def run_if_valid(&block)
    return unless already_run?
    return @result = :self if own_message?
    return @result = :not_understood if no_such_command
    return @result = :ignored unless will_read?

    yield if block
    @result = :ok
  end
end
