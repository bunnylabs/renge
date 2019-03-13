class CreateBotPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :bot_players, id: :uuid do |t|
      t.references :bot, index: {:unique=>true}, foreign_key: true, null: false
      t.references :player, index: {:unique=>true}, foreign_key: true, null: false

      t.datetime :updated_at
    end
    add_index :bot_players, %i[bot_id player_id], unique: true
  end
end
