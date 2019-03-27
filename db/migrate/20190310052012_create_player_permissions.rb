class CreatePlayerPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :player_permissions, id: :uuid do |t|
      t.references :player, foreign_key: true, null: false
      t.references :permission, foreign_key: true, null: false

      t.datetime :updated_at
    end
    add_index :player_permissions, %i[player_id permission_id], unique: true
  end
end
