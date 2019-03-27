class CreateSeiyuus < ActiveRecord::Migration[5.2]
  def change
    create_table :seiyuus, id: :uuid do |t|
      t.text :name, null: false

      t.datetime :updated_at
    end
    add_index :seiyuus, :name, unique: true
  end
end
