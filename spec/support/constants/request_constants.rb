# frozen_string_literal: true

# Constants related to requests
module RequestConstants
  NORMAL_REQUEST = {
    bot_key: '123',
    bot_username: 'somebot',

    author_key: '3456',
    author_username: 'testuser',
    author_is_bot: false,

    room_type: 'text',
    room_key: '23456',
    room_name: 'testroom',

    created_at: '1234',
    edited_at: '1235',

    message: 'hello',
    message_key: 'M123456',

    server_key: '123456',
    server_name: 'Test Server'
  }.freeze
end
