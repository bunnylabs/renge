class CreateAdminPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_players, id: :uuid do |t|
      t.references :player, index: {:unique=>true}, foreign_key: true, null: false

      t.datetime :updated_at
    end
  end
end
