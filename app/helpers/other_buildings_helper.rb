# frozen_string_literal: true

module OtherBuildingsHelper
  extend self
  include BuildingsHelper

  def get_building_costs(level, building_id)
    base_cost = get_base_building_costs(building_id)
    {
      titanium: base_cost[:titanium] * base_cost[:factor]**(level - 1),
      crystal: base_cost[:crystal] * base_cost[:factor]**(level - 1),
      hydrogen: base_cost[:hydrogen] * base_cost[:factor]**(level - 1),
    }.transform_values(&:floor)
  end
end
