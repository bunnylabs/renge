# frozen_string_literal: true

# Information about bots
class Bot < ApplicationRecord
  has_one :bot_player, dependent: :destroy
  has_one :player, through: :bot_player
end
