# frozen_string_literal: true

module V1
  # Endpoint for receiving discord messages
  class ChatApi < Grape::API
    resource :chat do
      desc 'Chat Message'
      params do
        requires :chat_source,     type: String
        requires :bot_id,          type: String
        requires :bot_username,    type: String

        requires :author_id,       type: String
        requires :author_username, type: String
        requires :author_is_bot,   type: Boolean

        requires :room_type,       type: String
        requires :room_id,         type: String
        optional :room_name,       type: String

        requires :created_at,      type: String
        optional :edited_at,       type: String

        requires :message,         type: String

        optional :server_id,       type: String
        optional :server_name,     type: String

        optional :attachments, type: Array do
          requires :attachment_id, type: String
          requires :filename,      type: String
          requires :url,           type: String
          requires :is_image,      type: Boolean
        end
      end
      post ':chat_source' do
        MessageProcessingService.process(params.with_indifferent_access)
      end
    end
  end
end
