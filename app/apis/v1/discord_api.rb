# frozen_string_literal: true

module V1
  # Endpoint for receiving discord messages
  class DiscordApi < Grape::API
    resource :discord do
      desc 'Discord Message'
      params do
        requires :author_id,       type: Integer
        requires :author_username, type: String
        requires :author_is_bot,   type: Boolean

        requires :room_type,       type: String
        requires :room_id,         type: Integer
        optional :room_name,       type: String

        requires :created_at,      type: Integer
        optional :edited_at,       type: Integer

        requires :message,         type: String

        optional :server_id,       type: Integer
        optional :server_name,     type: String

        optional :attachments, type: Array do
          requires :id,            type: Integer
          requires :filename,      type: String
          requires :url,           type: String
          requires :is_image,      type: Boolean
        end
      end
      post do
        processor = DiscordMessageProcessingService.new
        processor.process params
        { result: processor.result }
      end
    end
  end
end
