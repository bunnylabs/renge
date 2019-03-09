# frozen_string_literal: true

# Constants related to requests
module RequestConstants
  NORMAL_REQUEST = {
    bot_id: '123',
    bot_username: 'somebot',

    author_id: '3456',
    author_username: 'testuser',
    author_is_bot: false,

    room_type: 'text',
    room_id: '23456',
    room_name: 'testroom',

    created_at: '1234',
    edited_at: '1235',

    message: 'hello',

    server_id: '123456',
    server_name: 'Test Server'
  }.freeze
end
