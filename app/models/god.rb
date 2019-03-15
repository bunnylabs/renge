# frozen_string_literal: true

# Gods or administrators can use every command
class God < ApplicationRecord
  has_one :god_player, dependent: :destroy
  has_one :player, through: :god_player
end
