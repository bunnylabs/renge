class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players, id: :uuid do |t|
      t.string :chat_source, null: false
      t.string :user_id, null: false

      t.datetime :updated_at
    end
    add_index :players, %i[chat_source user_id], unique: true
  end
end
