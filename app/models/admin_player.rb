# frozen_string_literal: true

# Administrators. These players can do anything
class AdminPlayer < ApplicationRecord
  ulid :player_id
  belongs_to :player
end
