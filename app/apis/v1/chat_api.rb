# frozen_string_literal: true

module V1
  # Endpoint for receiving discord messages
  class ChatApi < Grape::API
    resource :chat do
      desc 'Chat Message'
      params do
        requires :chat_source,     type: String
        requires :bot_key,         type: String
        requires :bot_username,    type: String

        requires :author_key,      type: String
        requires :author_username, type: String
        requires :author_is_bot,   type: Boolean

        requires :room_type,       type: String
        requires :room_key,        type: String
        optional :room_name,       type: String

        requires :created_at,      type: String
        optional :edited_at,       type: String

        requires :message,         type: String
        requires :message_key,     type: String

        optional :server_key,      type: String
        optional :server_name,     type: String

        optional :attachments, type: Array do
          requires :attachment_key, type: String
          optional :filename,       type: String
          requires :url,            type: String
          requires :is_image,       type: Boolean
        end
      end
      post ':chat_source' do
        MessageProcessingService.process(params.deep_symbolize_keys)
      rescue => e
        { error: e }
      end
    end
  end
end
