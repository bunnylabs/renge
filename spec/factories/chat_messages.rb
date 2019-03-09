# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message do
    chat_source { 'bunnychat' }
    bot_id { 'B12345' }
    bot_username { 'bunnybot' }
    author_id { 'U1234' }
    author_username { 'astrobunny' }
    author_is_bot { false }
    room_type { 'text' }
    room_id { 'R23456' }
    room_name { 'general' }
    message { 'hello world' }
    server_id { 'S12345' }
    server_name { 'Rabbit House' }
  end
end
