# frozen_string_literal: true

# Base command
class ApplicationCommand < DiscordMessageService
  # Does this command only responds to directed commands?
  def directed_only?
    true
  end

  def run; end
end
