# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ChatApi, type: :request do
  let(:normal_message) { RequestConstants::NORMAL_REQUEST }

  it 'returns correctly' do
    expect(MessageProcessingService)
      .to receive(:process)
      .with(**normal_message, chat_source: 'discord')

    post '/api/v1/chat/discord', params: normal_message
  end
end
