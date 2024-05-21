class CreateBuildings < ActiveRecord::Migration[7.1]
  def change
    create_table :buildings, id: :uuid do |t|
      t.references :planet, null: false, foreign_key: true, type: :uuid
      t.integer :titanium_foundry, default: 0
      t.integer :auronium_synthesizer, default: 0
      t.integer :hydrogen_extractor, default: 0
      t.integer :solar_array, default: 0
      t.integer :fusion_power_plant, default: 0
      t.integer :lunar_mine, default: 0
      t.integer :advanced_research_institute, default: 0
      t.integer :aerospace_yard, default: 0
      t.integer :geomorphological_reshaper, default: 0
      t.integer :robotics_workshop, default: 0
      t.integer :nano_assembly_factory, default: 0
      t.integer :auronium_repository, default: 0
      t.integer :hydrogen_tank, default: 0
      t.integer :titanium_depot, default: 0
      t.integer :star_ship_hangar, default: 0
      t.integer :missile_silo, default: 0


      t.timestamps
    end
  end
end
