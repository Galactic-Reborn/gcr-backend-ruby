class CreateUniverseFields  < ActiveRecord::Migration[7.1]
  def change
    create_table :universe_fields, id: :uuid do |t|
      t.integer :pos_galaxy
      t.integer :pos_system
      t.integer :pos_planet
      t.references :planet,  foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
