# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should validate_presence_of(:chat_source) }
  it { should validate_presence_of(:user_key) }
end
