class CreatePlayerSeiyuus < ActiveRecord::Migration[5.2]
  def change
    create_table :player_seiyuus, id: :uuid do |t|
      t.references :player, foreign_key: true, null: false
      t.references :seiyuu, foreign_key: true, null: false

      t.datetime :updated_at
    end
    add_index :player_seiyuus, %i[player_id seiyuu_id], unique: true
  end
end
