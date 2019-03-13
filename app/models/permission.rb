# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :player_permissions
  has_many :players, through: :player_permissions
end
