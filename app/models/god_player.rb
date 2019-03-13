# frozen_string_literal: true

class GodPlayer < ApplicationRecord
  ulid :player_id
  ulid :god_id
  belongs_to :god
  belongs_to :player
end
