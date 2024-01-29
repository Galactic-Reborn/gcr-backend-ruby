# frozen_string_literal: true

module TitaniumFoundryHelper
  extend self
  include BuildingsHelper

  def get_building_costs(level)
    base_cost = get_base_building_costs(BuildingConstants::BUILDINGS_ID[:titaniumFoundry])
    {
      titanium: base_cost[:titanium] * base_cost[:factor]**(level - 1),
      crystal: base_cost[:crystal] * base_cost[:factor]**(level - 1),
      hydrogen: base_cost[:hydrogen] * base_cost[:factor]**(level - 1),
    }.transform_values(&:floor)
  end

  def get_production_rate(level)
    (30 * GameConfig::SPEED * level * 1.1 ** level).floor
  end

  def get_energy_consumption(level)
    (10 * level * 1.1 ** level).floor
  end
end
