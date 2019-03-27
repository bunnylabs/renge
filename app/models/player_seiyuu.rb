# frozen_string_literal: true

# The seiyuus that players have
class PlayerSeiyuu < ApplicationRecord
  ulid :player_id
  belongs_to :player
  ulid :seiyuu_id
  belongs_to :seiyuu

  validates :player_id, uniqueness: { scope: :seiyuu_id }
end
