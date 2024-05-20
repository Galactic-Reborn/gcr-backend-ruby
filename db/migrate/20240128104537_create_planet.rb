  class CreatePlanet < ActiveRecord::Migration[7.1]
  def change
    create_table :planets, id: :uuid do |t|
      t.references :user,  foreign_key: true, type: :uuid
      t.string :name, default: ""
      t.datetime :last_updated
      t.integer :planet_type
      t.string :planet_image
      t.integer :planet_diameter
      t.integer :fields_current
      t.integer :fields_max
      t.integer :temp_min
      t.integer :temp_max
      t.integer :titanium
      t.integer :auronium
      t.integer :hydrogen
      t.integer :energy
      t.integer :energy_used
      t.integer :energy_max
      t.integer :stardust
      t.integer :titanium_mine_percentage
      t.integer :auronium_mine_percentage
      t.integer :hydrogen_mine_percentage
      t.integer :building_id
      t.integer :building_end_time
      t.boolean :building_demolition
      t.json :hangar_queue
      t.datetime :hangar_start_time
      t.boolean :hangar_plus



      t.timestamps
    end
  end
end
