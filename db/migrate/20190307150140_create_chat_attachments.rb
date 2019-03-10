class CreateChatAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_attachments, id: :uuid do |t|
      t.references :chat_message, foreign_key: true, null: false
      t.string :attachment_id
      t.string :filename
      t.string :url
      t.boolean :is_image
      t.jsonb :other_params

      t.datetime :updated_at
    end

    add_index :chat_attachments, :attachment_id
    add_index :chat_attachments, :filename
    add_index :chat_attachments, :url
    add_index :chat_attachments, :other_params, using: :gin
  end
end
