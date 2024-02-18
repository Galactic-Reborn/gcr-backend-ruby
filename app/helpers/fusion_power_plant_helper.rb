module FusionPowerPlantHelper
  extend self
  include BuildingsHelper

  def get_building_costs(level)
    base_cost = get_base_building_costs(BuildingConstants::BUILDINGS_ID[:fusion_power_plant])
    {
      titanium: base_cost[:titanium] * base_cost[:factor]**(level - 1),
      auronium: base_cost[:auronium] * base_cost[:factor]**(level - 1),
      hydrogen: base_cost[:hydrogen] * base_cost[:factor]**(level - 1),
    }.transform_values(&:floor)
  end

  def get_production_rate(level, energy_tech_level = 1)
    hydrogen_consumption = get_hydrogen_consumption(level)
    return 0 if hydrogen_consumption.zero?

    energy_production = (30 * level * (1.05 * (1.1 * energy_tech_level))**level).floor

    efficiency = get_efficiency(energy_production, hydrogen_consumption)
    (efficiency * hydrogen_consumption).floor
  end

  def get_hydrogen_consumption(level)
    (10 * GameConfig::SPEED * level * 1.1**level).floor
  end

  def get_efficiency(energy, hydrogen)
    (energy / hydrogen).floor
  end
end
