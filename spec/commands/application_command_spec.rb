# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCommand do
  subject { described_class.new({}) }

  describe '#directed_only?' do
    it 'defaults to true' do
      expect(subject.directed_only?).to eq true
    end
  end
end
