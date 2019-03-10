# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_10_052012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admin_players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "player_id", null: false
    t.datetime "updated_at"
    t.index ["player_id"], name: "index_admin_players_on_player_id", unique: true
  end

  create_table "admins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "blacklist_entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "player_id", null: false
    t.datetime "updated_at"
    t.index ["player_id"], name: "index_blacklist_entries_on_player_id", unique: true
  end

  create_table "bots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "player_id", null: false
    t.string "bot_password", null: false
    t.jsonb "response_auth_document", null: false
    t.datetime "updated_at"
    t.index ["player_id"], name: "index_bots_on_player_id", unique: true
  end

  create_table "chat_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "chat_message_id", null: false
    t.string "attachment_id"
    t.string "filename"
    t.string "url"
    t.boolean "is_image"
    t.jsonb "other_params"
    t.datetime "updated_at"
    t.index ["attachment_id"], name: "index_chat_attachments_on_attachment_id"
    t.index ["chat_message_id"], name: "index_chat_attachments_on_chat_message_id"
    t.index ["filename"], name: "index_chat_attachments_on_filename"
    t.index ["other_params"], name: "index_chat_attachments_on_other_params", using: :gin
    t.index ["url"], name: "index_chat_attachments_on_url"
  end

  create_table "chat_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "chat_source", null: false
    t.string "bot_id", null: false
    t.string "bot_username", null: false
    t.string "author_id", null: false
    t.string "author_username", null: false
    t.boolean "author_is_bot", null: false
    t.string "room_type", null: false
    t.string "room_id"
    t.string "room_name"
    t.string "message", null: false
    t.string "server_id", null: false
    t.string "server_name", null: false
    t.boolean "processed", default: false
    t.jsonb "other_params", default: "{}"
    t.datetime "updated_at"
    t.index ["author_id"], name: "index_chat_messages_on_author_id"
    t.index ["author_username"], name: "index_chat_messages_on_author_username"
    t.index ["bot_id"], name: "index_chat_messages_on_bot_id"
    t.index ["bot_username"], name: "index_chat_messages_on_bot_username"
    t.index ["chat_source"], name: "index_chat_messages_on_chat_source"
    t.index ["message"], name: "index_chat_messages_on_message"
    t.index ["other_params"], name: "index_chat_messages_on_other_params", using: :gin
    t.index ["room_id"], name: "index_chat_messages_on_room_id"
    t.index ["room_name"], name: "index_chat_messages_on_room_name"
    t.index ["room_type"], name: "index_chat_messages_on_room_type"
    t.index ["server_id"], name: "index_chat_messages_on_server_id"
    t.index ["server_name"], name: "index_chat_messages_on_server_name"
  end

  create_table "permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "updated_at"
    t.index ["name"], name: "index_permissions_on_name", unique: true
  end

  create_table "player_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "player_id", null: false
    t.uuid "permission_id", null: false
    t.datetime "updated_at"
    t.index ["permission_id"], name: "index_player_permissions_on_permission_id"
    t.index ["player_id", "permission_id"], name: "index_player_permissions_on_player_id_and_permission_id", unique: true
    t.index ["player_id"], name: "index_player_permissions_on_player_id"
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "chat_source", null: false
    t.string "user_id", null: false
    t.datetime "updated_at"
    t.index ["chat_source", "user_id"], name: "index_players_on_chat_source_and_user_id", unique: true
  end

  create_table "versions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "item_type", null: false
    t.uuid "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "admin_players", "players"
  add_foreign_key "blacklist_entries", "players"
  add_foreign_key "bots", "players"
  add_foreign_key "chat_attachments", "chat_messages"
  add_foreign_key "player_permissions", "permissions"
  add_foreign_key "player_permissions", "players"
end
