# frozen_string_literal: true

# A permission to use a command or subcommand
class Permission < ApplicationRecord
  has_many :player_permissions
  has_many :players, through: :player_permissions
end
