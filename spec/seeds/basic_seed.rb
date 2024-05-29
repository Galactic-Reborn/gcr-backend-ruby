require 'rails_helper'

RSpec.shared_examples "basic_seed" do

  let(:adrian) { User.find_by(username: 'Adrian') }
  let(:milosz) { User.find_by(username: 'Milosz') }
  let(:milosz_planet) { Planet.find_by(name: 'Milosz Planet') }
  let(:adrian_planet) { Planet.find_by(name: 'Adrian Planet') }
  let(:adrian_building) { Building.find_by(planet_id: adrian_planet.id) }
  let(:milosz_building) { Building.find_by(planet_id: milosz_planet.id) }

  before(:each) do
    load_test_data
  end

  def create_universe
    fields_to_create = []
    (1..2).each do |i|
      (1..2).each do |j|
        (1..15).each do |k|
          fields_to_create << {
            pos_galaxy: i,
            pos_system: j,
            pos_planet: k,
          }
        end
      end
    end
    fields = UniverseField.create!(fields_to_create)

    planets_to_create = []
    buildings_to_create = []

    fields.each do |field|
      planet_index = field[:pos_planet]

      planet_fields = {
        name: SolarSystemConstants::SOLAR_SYSTEM_PLANET_NAMES[planet_index],
        planet_type: SolarSystemConstants::SOLAR_SYSTEM_PLANET_TYPES[planet_index],
        planet_image: SolarSystemConstants::SOLAR_SYSTEM_PLANET_IMAGES[planet_index],
        planet_diameter: SolarSystemConstants::SOLAR_SYSTEM_PLANET_DIAMETERS[planet_index],
        user_id: nil,
        fields_max: UniverseFieldsHelper.calculate_max_fields(SolarSystemConstants::SOLAR_SYSTEM_PLANET_DIAMETERS[planet_index]),
        temp_max: SolarSystemConstants::SOLAR_SYSTEM_PLANET_TEMPERATURES[planet_index][:max],
        temp_min: SolarSystemConstants::SOLAR_SYSTEM_PLANET_TEMPERATURES[planet_index][:min],
        auronium: SolarSystemConstants::SOLAR_SYSTEM_PLANET_RESOURCES[planet_index][:auronium],
        hydrogen: SolarSystemConstants::SOLAR_SYSTEM_PLANET_RESOURCES[planet_index][:hydrogen],
        titanium: SolarSystemConstants::SOLAR_SYSTEM_PLANET_RESOURCES[planet_index][:titanium],
        universe_field_id: field[:id]
      }
      planets_to_create << planet_fields
    end

    planets = Planet.create!(planets_to_create)

    planets.each do |planet|
      building = {
        planet_id: planet.id,
      }
      buildings_to_create << building
    end

    Building.create!(buildings_to_create)
  end

  def load_test_data
    create_universe

    User.create!(
      username: 'Milosz',
      address: Eth::Key.new.address,
    )

    User.create!(
      username: 'Adrian',
      address: Eth::Key.new.address,
    )

    milosz_planet = Planet.where(user_id: milosz.id).first
    adrian_planet = Planet.where(user_id: adrian.id).first

    adrian_planet.update(name: 'Adrian Planet')
    milosz_planet.update(name: 'Milosz Planet')
  end

end