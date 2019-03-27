# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlayerPermission, type: :model do
  it { should validate_presence_of(:player) }
  it { should validate_presence_of(:permission) }
end
