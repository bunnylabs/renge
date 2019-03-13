# frozen_string_literal: true

# List of players seen by the bot before
class Player < ApplicationRecord
  has_one :god_player, dependent: :destroy
  has_one :bot_player, dependent: :destroy
  has_one :bot, through: :bot_player
  has_one :god, through: :god_player

  has_many :player_permissions
  has_many :permissions, through: :player_permissions

  has_many :blacklist_entries

  def god?
    god.present?
  end

  def bot?
    bot.present?
  end

  def blacklisted?
    !blacklist_entries.empty?
  end
end
