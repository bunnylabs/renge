# frozen_string_literal: true

# The seiyuus that you can have
class Seiyuu < ApplicationRecord
  has_many :player_seiyuus
  has_many :players, through: :player_seiyuus

  validates_presence_of :name
end
