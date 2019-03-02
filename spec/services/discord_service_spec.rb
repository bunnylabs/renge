# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscordService do
  class FakeResponse
    def initialize(body)
      @body = body
    end

    def body
      @body.to_json
    end

    def code
      200
    end
  end

  before do
    DiscordService.instance_variable_set :@id, nil
    DiscordService.instance_variable_set :@username, nil
  end

  it 'gets id' do
    expect(DiscordService)
      .to receive(:call_bot)
      .with('GET', '/id')
      .and_return(FakeResponse.new(id: 5))

    DiscordService.id
  end

  it 'gets id and caches it' do
    expect(DiscordService)
      .to receive(:call_bot)
      .with('GET', '/id')
      .and_return(FakeResponse.new(id: 5))
      .once

    DiscordService.id
    DiscordService.id
  end

  it 'gets username' do
    expect(DiscordService)
      .to receive(:call_bot)
      .with('GET', '/username')
      .and_return(FakeResponse.new(username: 'alex'))

    DiscordService.username
  end

  it 'gets username and caches it' do
    expect(DiscordService)
      .to receive(:call_bot)
      .with('GET', '/username')
      .and_return(FakeResponse.new(username: 'alex'))
      .once

    DiscordService.username
    DiscordService.username
  end

  it 'can post message' do
    expect(DiscordService)
      .to receive(:call_bot)
      .with('PUT', '/messages', channel_id: '1234', message: 'msg')
      .and_return(FakeResponse.new({}))

    DiscordService.send_message(1234, 'msg')
  end
end
