# frozen_string_literal: true

module GeomorphologicalReshaperHelper
  extend self
  include BuildingsHelper

  def get_building_costs(level)
    base_cost = get_base_building_costs(BuildingConstants::BUILDINGS_ID[:geomorphological_reshaper])
    {
      titanium: base_cost[:titanium] * base_cost[:factor]**(level - 1),
      auronium: base_cost[:auronium] * base_cost[:factor]**(level - 1),
      hydrogen: base_cost[:hydrogen] * base_cost[:factor]**(level - 1),
    }.transform_values(&:floor)
  end

  def get_energy_consumption(level)
    return 0 if level.zero?

    (1000.0 * 2**(level - 1)).floor
  end
end
