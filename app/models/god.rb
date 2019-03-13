# frozen_string_literal: true

class God < ApplicationRecord
  has_one :god_player, dependent: :destroy
  has_one :player, through: :god_player
end
