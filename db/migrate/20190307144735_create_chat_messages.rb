class CreateChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages, id: :uuid do |t|
      t.string :chat_source, null: false
      t.string :bot_id, null: false
      t.string :bot_username, null: false
      t.string :author_id, null: false
      t.string :author_username, null: false
      t.boolean :author_is_bot, null: false
      t.string :room_type, null: false
      t.string :room_id
      t.string :room_name
      t.string :message, null: false
      t.string :server_id, null: false
      t.string :server_name, null: false

      t.boolean :processed, default: false
      t.jsonb :other_params, default: '{}'

      t.datetime :updated_at
    end

    add_index :chat_messages, :chat_source
    add_index :chat_messages, :bot_id
    add_index :chat_messages, :bot_username
    add_index :chat_messages, :author_id
    add_index :chat_messages, :author_username
    add_index :chat_messages, :room_type
    add_index :chat_messages, :room_id
    add_index :chat_messages, :room_name
    add_index :chat_messages, :message
    add_index :chat_messages, :server_id
    add_index :chat_messages, :server_name
    add_index :chat_messages, :other_params, using: :gin
  end
end
