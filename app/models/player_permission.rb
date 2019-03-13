# frozen_string_literal: true

class PlayerPermission < ApplicationRecord
  belongs_to :player
  belongs_to :permission
end
