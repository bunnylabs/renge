class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :name, index: {:unique=>true}, null: false

      t.datetime :updated_at
    end
  end
end
