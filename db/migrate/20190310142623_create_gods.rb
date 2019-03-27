class CreateGods < ActiveRecord::Migration[5.2]
  def change
    create_table :gods, id: :uuid do |t|
      t.boolean :active, null: false, default: false

      t.datetime :updated_at
    end
  end
end
