module BuildingsHelper
  extend self
  include BuildingConstants

  def get_base_building_costs(building_id)
    BUILDINGS_COSTS[building_id]
  end
end
