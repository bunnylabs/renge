# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscordMessageService do
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

  describe '#directed?' do
    context 'in a DM' do
      subject { described_class.new(**normal_message, room_type: 'dm') }

      it 'is always directed' do
        expect(subject)
          .to receive(:starts_with_username?)
          .and_return(true)
          .at_most(:once)

        expect(subject.directed?).to eq true
      end

      it 'is directed even if no username call' do
        expect(subject)
          .to receive(:starts_with_username?)
          .and_return(false)
          .at_most(:once)

        expect(subject.directed?).to eq true
      end
    end

    context 'in a channel' do
      subject { described_class.new(**normal_message, room_type: 'text', message: 'pikachu use tackle') }

      it 'is directed if starts with username' do
        expect(subject)
          .to receive(:starts_with_username?)
          .and_return(true)

        expect(subject.directed?).to eq true
      end

      it 'is not directed if does not start with username' do
        expect(subject)
          .to receive(:starts_with_username?)
          .and_return(false)

        expect(subject.directed?).to eq false
      end
    end
  end

  describe '#starts_with_username?' do
    context 'user refers to bot by username' do
      subject { described_class.new(**normal_message, message: 'pikachu hello') }

      before do
        allow(DiscordService)
          .to receive(:id)
          .and_return(1111)
      end

      it 'detects that that is its username' do
        expect(DiscordService)
          .to receive(:username)
          .and_return('pikachu')

        expect(subject.starts_with_username?).to eq true
      end

      it 'detects that that is not its username' do
        expect(DiscordService)
          .to receive(:username)
          .and_return('bulbasaur')

        expect(subject.starts_with_username?).to eq false
      end
    end

    context 'user refers to bot by @ mention' do
      subject { described_class.new(**normal_message, message: '<@111222333> hello') }

      before do
        allow(DiscordService)
          .to receive(:username)
          .and_return('bulbasaur')
      end

      it 'detects that it was mentioned' do
        expect(DiscordService)
          .to receive(:id)
          .and_return(111_222_333)

        expect(subject.starts_with_username?).to eq true
      end

      it 'detects that it was not mentioned' do
        expect(DiscordService)
          .to receive(:id)
          .and_return(999_999_999)

        expect(subject.starts_with_username?).to eq false
      end
    end
  end

  describe '#raw_tokens' do
    subject { described_class.new(**normal_message, message: 'charmander bulbasaur squirtle') }

    it 'tokenizes properly' do
      expect(subject.raw_tokens).to match_array %w[charmander bulbasaur squirtle]
    end
  end

  describe '#tokens' do
    subject { described_class.new(**normal_message, message: 'charmander bulbasaur squirtle') }

    it 'strips username if there' do
      expect(subject)
        .to receive(:starts_with_username?)
        .and_return(true)

      expect(subject.tokens).to match_array %w[bulbasaur squirtle]
    end

    it 'will not strip username if not there' do
      expect(subject)
        .to receive(:starts_with_username?)
        .and_return(false)

      expect(subject.tokens).to match_array %w[charmander bulbasaur squirtle]
    end
  end

  describe '#raw_message' do
    subject { described_class.new(**normal_message, message: 'charmander bulbasaur squirtle') }

    it 'returns the raw message' do
      expect(subject.raw_message).to eq 'charmander bulbasaur squirtle'
    end
  end

  describe '#message' do
    subject { described_class.new(**normal_message, message: 'charmander bulbasaur squirtle') }

    it 'strips username if there' do
      expect(subject)
        .to receive(:starts_with_username?)
        .and_return(true)

      expect(subject.message).to eq 'bulbasaur squirtle'
    end

    it 'will not strip username if not there' do
      expect(subject)
        .to receive(:starts_with_username?)
        .and_return(false)

      expect(subject.message).to eq 'charmander bulbasaur squirtle'
    end
  end

  describe '#command' do
    subject { described_class.new(**normal_message, message: 'pikachu use tackle') }

    it 'is the first word after username' do
      expect(subject)
        .to receive(:starts_with_username?)
        .and_return(true)

      expect(subject.command).to eq 'use'
    end

    it 'is the first word' do
      expect(subject)
        .to receive(:starts_with_username?)
        .and_return(false)

      expect(subject.command).to eq 'pikachu'
    end
  end

  describe '#command_class' do
    let(:use_command) { Class.new }
    let(:wrong_use_command) { Class.new }

    it 'gets the appropriate constant' do
      stub_const('UseCommand', use_command)
      stub_const('DiscordMessageService::UseCommand', wrong_use_command)
      expect(subject)
        .to receive(:command)
        .and_return('use')

      expect(subject.command_class).to eq use_command
    end

    it 'is nil when theres no constant' do
      expect(subject)
        .to receive(:command)
        .and_return('use')

      expect(subject.command_class).to be nil
    end
  end

  describe '#no_such_command?' do
    it 'is true when command does not exist' do
      expect(subject)
        .to receive(:command_class)
        .and_return(nil)

      expect(subject.no_such_command).to eq true
    end
  end

  describe '#author_id' do
    it 'returns the right id' do
      expect(subject.author_id).to eq '3456'
    end
  end

  describe '#room_id' do
    it 'returns the right id' do
      expect(subject.room_id).to eq '23456'
    end
  end

  describe '#reply' do
    it 'attempts to reply' do
      expect(DiscordService)
        .to receive(:send_message)
        .with('23456', 'good day')

      subject.reply('good day')
    end
  end
end
