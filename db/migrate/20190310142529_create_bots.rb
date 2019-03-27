class CreateBots < ActiveRecord::Migration[5.2]
  def change
    create_table :bots, id: :uuid do |t|
      t.string :bot_password, null: false
      t.jsonb :response_auth_document, null: false
      t.boolean :active, null: false, default: false

      t.datetime :updated_at
    end
  end
end
