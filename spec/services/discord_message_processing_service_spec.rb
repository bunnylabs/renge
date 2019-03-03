# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscordMessageProcessingService do
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

  subject { described_class.new(normal_message) }

  describe '#run' do
    let(:hello_command_class) { Class.new(ApplicationCommand) }
    let(:hello_command_instance) { instance_double(hello_command_class) }

    it 'gets run later' do
      stub_const('HelloCommand', hello_command_class)

      expect(hello_command_class)
        .to receive(:new)
        .with(normal_message)
        .and_return(hello_command_instance)

      allow(hello_command_instance)
        .to receive(:run)

      allow(hello_command_instance)
        .to receive(:directed_only?)
        .and_return(false)

      expect(CommandRunnerWorker)
        .to receive(:perform_async)
        .with(normal_message)

      subject.run
    end
  end

  describe '#run_now' do
  end
end
