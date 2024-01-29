# frozen_string_literal: true

module CalculationsHelper
  extend self
  def calculate_build_time_in_seconds(titanium_cost, crystal_cost, robotics_workshop, nano_assembly_factory)
    factor = 2500.0 * (1 + robotics_workshop) * 2 ** nano_assembly_factory * GameConfig::SPEED
    build_time_seconds = ((titanium_cost + crystal_cost) / factor) * 60 * 60
    build_time_seconds.round
  end
end
