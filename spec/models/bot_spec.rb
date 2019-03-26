# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bot, type: :model do
  it { should validate_presence_of(:bot_password) }
  it { should validate_presence_of(:response_auth_document) }
end
