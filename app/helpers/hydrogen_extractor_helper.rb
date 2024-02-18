# frozen_string_literal: true

module HydrogenExtractorHelper
  extend self
  include BuildingsHelper

  def get_building_costs(level)
    base_cost = get_base_building_costs(BuildingConstants::BUILDINGS_ID[:hydrogen_extractor])
    {
      titanium: base_cost[:titanium] * base_cost[:factor]**(level - 1),
      auronium: base_cost[:auronium] * base_cost[:factor]**(level - 1),
      hydrogen: base_cost[:hydrogen] * base_cost[:factor]**(level - 1),
    }.transform_values(&:floor)
  end

  def get_production_rate(level, avg_temp)
    max_energy_consumption = get_energy_consumption(level)
    (GameConfig::SPEED * max_energy_consumption * (0.68 - 0.002 * avg_temp)).floor
  end

  def get_energy_consumption(level)
    (20 * level * 1.1**level).floor
  end
end
