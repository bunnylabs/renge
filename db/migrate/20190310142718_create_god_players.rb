class CreateGodPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :god_players, id: :uuid do |t|
      t.references :god, index: {:unique=>true}, foreign_key: true, null: false
      t.references :player, index: {:unique=>true}, foreign_key: true, null: false

      t.datetime :updated_at
    end
    add_index :god_players, %i[god_id player_id], unique: true
  end
end
