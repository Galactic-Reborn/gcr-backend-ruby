# frozen_string_literal: true

module UniverseFieldsHelper
  extend self

  def create_universe_fields
    fields = []
    (1..GameConfig::GALAXIES).each do |i|
      (1..GameConfig::SOLAR_SYSTEM_PER_GALAXY).each do |j|
        (1..GameConfig::PLANETS_PER_SOLAR_SYSTEM).each do |k|
          fields << {
            pos_galaxy: i,
            pos_system: j,
            pos_planet: k,
          }
        end
      end
    end
    fields
  end

  def calculate_max_fields(diameter)
     (diameter / 100).floor
  end

end
