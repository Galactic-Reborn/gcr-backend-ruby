require 'rails_helper'

RSpec.shared_examples "basic_seed" do

  let(:adrian) { User.find_by(username: 'Adrian') }
  let(:milosz) { User.find_by(username: 'Milosz') }
  let(:milosz_planet) { Planet.find_by(user_id: milosz.id) }
  let(:adrian_planet) { Planet.find_by(user_id: adrian.id) }
  let(:adrian_building) { Building.find_by(planet_id: adrian_planet.id) }
  let(:milosz_building) { Building.find_by(planet_id: milosz_planet.id) }

  before(:each) do
    load_test_data
  end

  def load_test_data
    field_adrian = UniverseField.create!(
      pos_planet: 6,
      pos_system: 1,
      pos_galaxy: 1,
    )

    field_milosz = UniverseField.create!(
      pos_planet: 7,
      pos_system: 1,
      pos_galaxy: 1,
    )

    planet = Planet.create!(
      name: 'Milosz Planet',
      last_updated: Time.now - 1.hour,
      planet_type: 1,
      planet_image: 'milosz_planet.jpg',
      planet_diameter: 100,
      fields_current: 90,
      fields_max: 100,
      temp_min: 100,
      temp_max: 100,
      titanium: 1000,
      auronium: 1000,
      hydrogen: 1000,
      energy: 100,
      energy_used: 0,
      energy_max: 100,
      stardust: 100,
      building_id: 0,
      building_end_time: 0,
      building_demolition: false,
      hangar_queue: [],
      hangar_start_time: 0,
      hangar_plus: false,
      user_id: nil,
      universe_field_id: field_milosz.id
    )

    Building.create!(
      planet_id: planet.id,
      titanium_foundry: 1,
      titanium_depot: 1,
      auronium_synthesizer: 1,
      hydrogen_extractor: 1,
      auronium_repository: 1,
      solar_array: 2,
      fusion_power_plant: 1,
    )

    field_milosz.planet_id = planet.id
    field_milosz.save

    planet = Planet.create!(
      name: 'Adrian Planet',
      last_updated: Time.now - 1.hour,
      planet_type: 1,
      planet_image: 'adrian_planet.jpg',
      planet_diameter: 100,
      fields_current: 90,
      fields_max: 100,
      temp_min: 100,
      temp_max: 100,
      titanium: 1000,
      auronium: 1000,
      hydrogen: 1000,
      energy: 100,
      energy_used: 0,
      energy_max: 100,
      stardust: 100,
      building_id: 0,
      building_end_time: 0,
      building_demolition: false,
      hangar_queue: [],
      hangar_start_time: 0,
      hangar_plus: false,
      user_id: nil,
      universe_field_id: field_adrian.id
    )

    Building.create!(
      planet_id: planet.id,
      titanium_foundry: 1,
      titanium_depot: 1,
      auronium_synthesizer: 1,
      hydrogen_extractor: 1,
      auronium_repository: 1,
      solar_array: 2,
      fusion_power_plant: 1,
    )

    field_adrian.planet_id = planet.id
    field_adrian.save

    User.create!(
      username: 'Milosz',
      address: Eth::Key.new.address,
    )

    User.create!(
      username: 'Adrian',
      address: Eth::Key.new.address,
    )

    field = UniverseField.create!(
      pos_planet: 6,
      pos_system: 2,
      pos_galaxy: 1,
    )

    planet = Planet.create!(
      name: 'Terra 1',
      last_updated: Time.now - 1.hour,
      planet_type: 1,
      planet_image: 'terra_1.jpg',
      planet_diameter: 100,
      fields_current: 90,
      fields_max: 100,
      temp_min: 100,
      temp_max: 100,
      titanium: 1000,
      auronium: 1000,
      hydrogen: 1000,
      energy: 100,
      energy_used: 0,
      energy_max: 100,
      stardust: 100,
      building_id: 0,
      building_end_time: 0,
      building_demolition: false,
      hangar_queue: [],
      hangar_start_time: 0,
      hangar_plus: false,
      user_id: nil,
      universe_field_id: field.id
    )

    Building.create!(
      planet_id: planet.id,
      titanium_foundry: 1,
      titanium_depot: 1,
      auronium_synthesizer: 1,
      hydrogen_extractor: 1,
      auronium_repository: 1,
      solar_array: 2,
      fusion_power_plant: 1,
    )

    field = UniverseField.create!(
      pos_planet: 8,
      pos_system: 1,
      pos_galaxy: 2,
    )

    planet = Planet.create!(
      name: 'Terra 2',
      last_updated: Time.now - 1.hour,
      planet_type: 1,
      planet_image: 'terra_2.jpg',
      planet_diameter: 100,
      fields_current: 90,
      fields_max: 100,
      temp_min: 100,
      temp_max: 100,
      titanium: 1000,
      auronium: 1000,
      hydrogen: 1000,
      energy: 100,
      energy_used: 0,
      energy_max: 100,
      stardust: 100,
      building_id: 0,
      building_end_time: 0,
      building_demolition: false,
      hangar_queue: [],
      hangar_start_time: 0,
      hangar_plus: false,
      user_id: nil,
      universe_field_id: field.id
    )

    Building.create!(
      planet_id: planet.id,
      titanium_foundry: 1,
      titanium_depot: 1,
      auronium_synthesizer: 1,
      hydrogen_extractor: 1,
      auronium_repository: 1,
      solar_array: 2,
      fusion_power_plant: 1,
    )


  end

end