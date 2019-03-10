# frozen_string_literal: true

# This class takes apart chat parameters
class ChatParametersService
  def initialize(params)
    @params = params.symbolize_keys
  end

  def non_main_keys
    %w[id updated_at other_params processed]
  end

  def main_chat_message_keys
    (ChatMessage.attribute_names - non_main_keys).map(&:to_sym)
  end

  def main_chat_attachment_keys
    (ChatAttachment.attribute_names - non_main_keys).map(&:to_sym)
  end

  def other_chat_message_params
    @params.except(*main_chat_message_keys, :attachments)
  end

  def other_attachment_params_group
    @params[:attachments].map do |att|
      att.symbolize_keys!
      {
        **att.slice(*main_chat_attachment_keys),
        other_params: other_attachment_params(att)
      }
    end
  end

  def other_attachment_params(attachment_param)
    attachment_param.except(*main_chat_attachment_keys)
  end

  def writable_params
    {
      **@params.slice(*main_chat_message_keys),
      other_params: other_chat_message_params,
      chat_attachments_attributes: other_attachment_params_group
    }
  end

  def permitted_param_keys
    [
      *main_chat_message_keys,
      other_params: {},
      chat_attachments_attributes: [
        *main_chat_attachment_keys,
        other_params: {}
      ]
    ]
  end

  def permitted_params
    ActionController::Parameters
      .new(writable_params)
      .permit(permitted_param_keys)
  end
end
