# frozen_string_literal: true

# Represents a bot player
class BotPlayer < ApplicationRecord
  ulid :player_id
  ulid :bot_id
  belongs_to :bot
  belongs_to :player
end
