module AuroniumRepositoryHelper
  extend self
  include BuildingsHelper

  def get_building_costs(level)
    base_cost = get_base_building_costs(BuildingConstants::BUILDINGS_ID[:auronium_repository])
    {
      titanium: base_cost[:titanium] * base_cost[:factor] ** (level - 1),
      auronium: base_cost[:auronium] * base_cost[:factor] ** (level - 1),
      hydrogen: base_cost[:hydrogen] * base_cost[:factor] ** (level - 1),
    }.transform_values(&:floor)
  end

  def get_storage_capacity(level)
    (10000.0 * 2**level).round
  end
end