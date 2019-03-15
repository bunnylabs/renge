# frozen_string_literal: true

# Associates a player with a God
class GodPlayer < ApplicationRecord
  ulid :player_id
  ulid :god_id
  belongs_to :god
  belongs_to :player
end
