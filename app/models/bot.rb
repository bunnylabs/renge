# frozen_string_literal: true

class Bot < ApplicationRecord
  has_one :bot_player, dependent: :destroy
  has_one :player, through: :bot_player
end
