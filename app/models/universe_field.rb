# frozen_string_literal: true

# == Schema Information
#
# Table name: universe_fields
#
#  id         :uuid             not null, primary key
#  pos_galaxy :integer
#  pos_planet :integer
#  pos_system :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  planet_id  :uuid
#
# Indexes
#
#  index_universe_fields_on_planet_id  (planet_id)
#
# Foreign Keys
#
#  fk_rails_...  (planet_id => planets.id)
#
class UniverseField < ApplicationRecord
  has_one :planet



  def self.create_universe
    fields_to_create = UniverseFieldsHelper.create_universe_fields
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
    true
  end


end
