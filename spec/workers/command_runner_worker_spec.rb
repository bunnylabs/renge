# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommandRunnerWorker do
  it 'calls the right stuff' do
    service = instance_double('DiscordMessageProcessingService')
    expect(DiscordMessageProcessingService)
      .to receive(:new)
      .with(a: 5)
      .and_return(service)
    expect(service).to receive(:run_now)

    subject.perform(a: 5)
  end

  it 'symbolizes keys' do
    service = instance_double('DiscordMessageProcessingService')
    expect(DiscordMessageProcessingService)
      .to receive(:new)
      .with(a: 5)
      .and_return(service)
    expect(service).to receive(:run_now)

    subject.perform('a' => 5)
  end
end
