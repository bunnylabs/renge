# frozen_string_literal: true

# Associates a permission with a player
class PlayerPermission < ApplicationRecord
  belongs_to :player
  belongs_to :permission
end
