# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatAttachment, type: :model do
  it { should validate_presence_of(:chat_message) }
  it { should validate_presence_of(:attachment_key) }
end
