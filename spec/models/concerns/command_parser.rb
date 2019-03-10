# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'CommandParser' do
  let(:model) { described_class } # the class that includes the concern
  let(:subject) { create :"#{described_class.name.underscore}" }

  describe '#directed?' do
    it 'is true if dm' do
      subject.room_type = 'dm'
      expect(subject.directed?).to be true
    end

    it 'is true if addressed to bot' do
      subject.room_type = 'text'
      subject.bot_username = 'pikachu'
      subject.message = 'pikachu hi'
      expect(subject.directed?).to be true
    end

    it 'is true if not addressed to bot' do
      subject.room_type = 'text'
      subject.bot_username = 'pikachu'
      subject.message = 'hello world'
      expect(subject.directed?).to be false
    end
  end

  describe '#starts_with_username?' do
    it 'is true if starts with id' do
      subject.bot_username = 'pikachu'
      subject.message = 'pikachu hello'
      expect(subject.starts_with_username?).to be true
    end

    it 'is true if starts with username' do
      subject.bot_id = '1234'
      subject.message = '<@1234> good day'
      expect(subject.starts_with_username?).to be true
    end

    it 'is false otherwise' do
      subject.bot_id = '1234'
      subject.bot_username = 'pikachu'
      subject.message = 'gotta catch them all'
      expect(subject.starts_with_username?).to be false
    end
  end

  describe '#raw_tokens' do
    it 'is all tokens' do
      subject.message = 'gotta catch them all'
      expect(subject.raw_tokens).to match_array %w[gotta catch them all]
    end
  end

  describe '#tokens' do
    it 'is token minus username' do
      subject.bot_username = 'pikachu'
      subject.message = 'pikachu good morning'
      expect(subject.tokens).to match_array %w[good morning]
    end
  end

  describe '#command_tokens' do
    it 'is token minus username' do
      subject.bot_username = 'pikachu'
      subject.message = 'pikachu good morning'
      expect(subject.command_tokens).to match_array %w[morning]
    end
  end

  describe '#command' do
    it 'is a command' do
      subject.bot_username = 'pikachu'
      subject.message = 'pikachu meow loudly'
      expect(subject.command).to eq 'meow'
    end
  end

  describe '#command_class' do
    let(:meow_command) { Class.new }
    let(:wrong_meow_command) { Class.new }

    it 'gets the appropriate constant' do
      stub_const('::MeowCommand', meow_command)
      stub_const('ChatMessage::MeowCommand', wrong_meow_command)
      subject.bot_username = 'pikachu'
      subject.message = 'pikachu meow loudly'
      expect(subject.command_class).to eq meow_command
    end
  end

  describe '#chat_service_prefix' do
    it 'gets the appropriate prefix' do
      subject.chat_source = 'bunnychat'
      expect(subject.chat_service_prefix).to eq 'Bunnychat'
    end
  end

  describe '#chat_service_class' do
    let(:chat_service) { Class.new }
    it 'gets the appropriate constant' do
      subject.chat_source = 'bunnychat'
      stub_const('Bunnychat::ChatService', chat_service)
      expect(subject.chat_service_class).to eq chat_service
    end
  end

  describe '#processable' do
    it 'is true if evaluation is :ok' do
      expect(subject)
        .to receive(:evaluation)
        .and_return(:ok)
      expect(subject.processable?).to eq true
    end

    it 'is false if evaluation is anything else' do
      expect(subject)
        .to receive(:evaluation)
        .and_return(:asdasdasd)
      expect(subject.processable?).to eq false
    end
  end

  describe '#evaluation' do
    it 'is ok if everything else is falsey' do
      allow(subject)
        .to receive(:no_such_command?)
        .and_return(nil)
      allow(subject)
        .to receive(:own_message?)
        .and_return(nil)
      allow(subject)
        .to receive(:unknown_source?)
        .and_return(nil)
      allow(subject)
        .to receive(:not_directed?)
        .and_return(nil)

      expect(subject.evaluation).to eq :ok
    end
  end

  describe '#no_such_command?' do
    let(:meow_command) { Class.new }
    before do
      stub_const('::MeowCommand', meow_command)
    end

    it 'is falsey if command is known' do
      subject.message = 'meow louder'
      expect(subject.no_such_command?).to be_falsey
    end

    it 'is no_such_command if command is unknown' do
      subject.message = 'meowo louder'
      expect(subject.no_such_command?).to eq :no_such_command
    end
  end

  describe '#own_message?' do
    it 'is true if message is own' do
      subject.bot_id = '1234'
      subject.author_id = '1234'
      expect(subject.own_message?).to eq :own_message
    end
  end

  describe '#unknown_source?' do
    let(:chat_service) { Class.new }
    it 'is falsey if source is known' do
      subject.chat_source = 'bunnychat'
      stub_const('Bunnychat::ChatService', chat_service)
      expect(subject.unknown_source?).to be_falsey
    end

    it 'is :unknown_source if source is not known' do
      expect(subject.unknown_source?).to eq :unknown_source
    end
  end

  describe '#not_directed?' do
    it 'returns false if no such command' do
      expect(subject)
        .to receive(:command_class)
        .and_return(nil)

      expect(subject.not_directed?).to be_falsey
    end

    it 'returns not_directed if command requires direction' do
      example_command_class = double(ApplicationCommand)
      example_command = instance_double(ApplicationCommand)
      allow(example_command_class)
        .to receive(:new)
        .and_return(example_command)

      allow(example_command)
        .to receive(:directed_only?)
        .and_return(true)

      expect(subject)
        .to receive(:command_class)
        .and_return(example_command_class)

      expect(subject)
        .to receive(:directed?)
        .and_return(false)

      expect(subject.not_directed?).to eq :not_directed
    end

    it 'returns falsey if command requires direction and gets it' do
      example_command_class = double(ApplicationCommand)
      example_command = instance_double(ApplicationCommand)
      allow(example_command_class)
        .to receive(:new)
        .and_return(example_command)

      allow(example_command)
        .to receive(:directed_only?)
        .and_return(true)

      expect(subject)
        .to receive(:command_class)
        .and_return(example_command_class)

      expect(subject)
        .to receive(:directed?)
        .and_return(true)

      expect(subject.not_directed?).to be_falsey
    end

    it 'returns falsey if direction not required' do
      example_command_class = double(ApplicationCommand)
      example_command = instance_double(ApplicationCommand)
      allow(example_command_class)
        .to receive(:new)
        .and_return(example_command)

      allow(example_command)
        .to receive(:directed_only?)
        .and_return(false)

      expect(subject)
        .to receive(:command_class)
        .and_return(example_command_class)

      expect(subject.not_directed?).to be_falsey
    end
  end
end
