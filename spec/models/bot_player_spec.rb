# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BotPlayer, type: :model do
  it { should validate_presence_of(:bot) }
  it { should validate_presence_of(:player) }
end
