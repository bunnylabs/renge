# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::DiscordApi, type: :request do
  let(:normal_message) do
    {
      author_id: 3456,
      author_username: 'testuser',
      author_is_bot: false,

      room_type: 'text',
      room_id: 23_456,
      room_name: 'testroom',

      created_at: 1234,
      edited_at: 1235,

      message: 'hello',

      server_id: 123_456,
      server_name: 'Test Server'
    }
  end

  it 'returns correctly' do
    service = instance_double('DiscordMessageProcessingService')
    expect(DiscordMessageProcessingService)
      .to receive(:new)
      .with(normal_message.stringify_keys)
      .and_return(service)
    expect(service).to receive(:run)
    expect(service).to receive(:result).and_return(:ok)

    post '/api/v1/discord', params: normal_message
    expect(response.body).to eq({ result: 'ok' }.to_json)
  end
end
