# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GodPlayer, type: :model do
  it { should validate_presence_of(:god) }
  it { should validate_presence_of(:player) }
end
