# frozen_string_literal: true

# Entry into blacklist. All players listed in this blacklist have their
# requests ignored
class BlacklistEntry < ApplicationRecord
  ulid :player_id
  belongs_to :player
end
