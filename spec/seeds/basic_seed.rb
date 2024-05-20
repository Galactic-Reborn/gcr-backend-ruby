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
    User.create!(
      username: 'Adrian',
      address: Eth::Key.new.address,
    )

    User.create!(
      username: 'Milosz',
      address: Eth::Key.new.address,
    )

    planet = Planet.create!(
      user_id: milosz.id,
      name: 'Milosz Planet',
      last_updated: Time.now-1.hour,
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
      titanium_mine_percentage: 100,
      auronium_mine_percentage: 100,
      hydrogen_mine_percentage: 100,
      building_id: 0,
      building_end_time: 0,
      building_demolition: false,
      hangar_queue: [],
      hangar_start_time: 0,
      hangar_plus: false,
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


    planet = Planet.create!(
      user_id: adrian.id,
      name: 'Adrian Planet',
      last_updated: Time.now-1.hour,
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
      titanium_mine_percentage: 100,
      auronium_mine_percentage: 100,
      hydrogen_mine_percentage: 100,
      building_id: 0,
      building_end_time: 0,
      building_demolition: false,
      hangar_queue: [],
      hangar_start_time: 0,
      hangar_plus: false,
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