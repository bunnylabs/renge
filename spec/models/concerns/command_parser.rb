# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'CommandParser' do
  let(:model) { described_class } # the class that includes the concern
  let(:subject) { create :"#{described_class.name.underscore}" }

  describe '#directed?' do
    it 'is true if dm' do
      expect(subject.directed?).to be false
    end
  end

  describe '#starts_with_username?' do
  end

  describe '#raw_tokens' do
  end

  describe '#tokens' do
  end

  describe '#command_tokens' do
  end

  describe '#command' do
  end

  describe '#command_class' do
  end

  describe '#chat_service_prefix' do
  end

  describe '#chat_service_class' do
  end

  describe '#processable' do
  end

  describe '#evaluation' do
  end

  describe '#no_such_command?' do
  end

  describe '#own_message?' do
  end

  describe '#unknown_source?' do
  end

  describe '#not_directed?' do
  end
end
