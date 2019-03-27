class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players, id: :uuid do |t|
      t.string :chat_source, null: false
      t.string :user_key, null: false

      t.datetime :updated_at
    end
    add_index :players, %i[chat_source user_key], unique: true
  end
end
