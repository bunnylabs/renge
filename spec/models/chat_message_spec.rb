# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  it_has_concern 'CommandParser'
  it { should validate_presence_of(:chat_source) }
  it { should validate_presence_of(:bot_id) }
  it { should validate_presence_of(:bot_username) }
  it { should validate_presence_of(:author_id) }
  it { should validate_presence_of(:author_username) }
  it { should validate_presence_of(:room_type) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:server_id) }
  it { should validate_presence_of(:server_name) }
end
