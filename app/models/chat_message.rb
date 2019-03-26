# frozen_string_literal: true

# Represents a chat message
class ChatMessage < ApplicationRecord
  include CommandParser

  has_many :chat_attachments
  accepts_nested_attributes_for :chat_attachments

  validates_presence_of :chat_source
  validates_presence_of :bot_key
  validates_presence_of :bot_username
  validates_presence_of :author_key
  validates_presence_of :author_username
  validates_presence_of :room_type
  validates_presence_of :message
  validates_presence_of :message_key
  validates_presence_of :server_key
  validates_presence_of :server_name

  def bot
    Bot
      .joins(:player)
      .merge(Player.where(chat_source: chat_source, user_key: bot_key))
      .first
  end

  def author
    Player.find_by(chat_source: chat_source, user_key: author_key)
  end
end
