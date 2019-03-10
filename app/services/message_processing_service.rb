# frozen_string_literal: true

# This class processes messages from all chat services
class MessageProcessingService
  class << self
    def process(params)
      chatparams = ChatParametersService.new(params)
      message = ChatMessage.create(chatparams.permitted_params)

      if message.processable?
        CommandRunnerWorker.perform_async(
          message_id: message.id
        )
      end
      message.evaluation
    end
  end
end
