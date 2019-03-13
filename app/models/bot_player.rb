# frozen_string_literal: true

class BotPlayer < ApplicationRecord
  ulid :player_id
  ulid :bot_id
  belongs_to :bot
  belongs_to :player
end
