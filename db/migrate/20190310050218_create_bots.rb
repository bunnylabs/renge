class CreateBots < ActiveRecord::Migration[5.2]
  def change
    create_table :bots, id: :uuid do |t|
      t.references :player, index: {:unique=>true}, foreign_key: true, null: false
      t.string :bot_password, null: false
      t.jsonb :response_auth_document, null: false

      t.datetime :updated_at
    end
  end
end
