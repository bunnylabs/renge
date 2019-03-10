# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EchoCommand do
  let(:chat_message) { create :chat_message }
  let(:chat_service) { ApplicationChatService.new(chat_message) }

  subject { described_class.new(chat_service) }

  describe '#zero_width_space' do
    it 'is not empty' do
      expect(subject.zero_width_space.length).to eq 1
    end
  end

  describe '#safe_triple_backtick' do
    it 'is five chars long' do
      expect(subject.safe_triple_backtick.length).to eq 5
    end
  end

  describe '#quoted' do
    it 'makes quoted string' do
      expect(subject.quoted).to eq '"hello world"'
    end
  end

  describe '#escaped_quoted_string' do
    let(:chat_message) { create :chat_message, message: '```hello```' }
    it 'makes escaped string string' do
      expect(subject.escaped_quoted_string).to eq '"`​`​`hello`​`​`"'
    end
  end

  describe '#run' do
    it 'replies' do
      expect(chat_service)
        .to receive(:reply)
        .with("```\n#{subject.escaped_quoted_string}\n```")

      subject.run
    end
  end
end
