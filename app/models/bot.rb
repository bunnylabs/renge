# frozen_string_literal: true

# Bot players. They can only do bot things
class Bot < ApplicationRecord
  ulid :player_id
  belongs_to :player
end
