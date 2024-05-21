module BuildingsHelper
  extend self
  include BuildingConstants

  def get_base_building_costs(building_id)
    BUILDINGS_COSTS[building_id]
  end

  def get_produced_resources(per_hour, time_difference)
    (per_hour * time_difference / 3600).floor
  end

  def calculate_building_costs(level, building_id)
    case building_id
    when BUILDINGS_ID[:auronium_repository]
      AuroniumRepositoryHelper.get_building_costs(level)
    when BUILDINGS_ID[:auronium_synthesizer]
      AuroniumSynthesizerHelper.get_building_costs(level)
    when BUILDINGS_ID[:titanium_depot]
      TitaniumDepotHelper.get_building_costs(level)
    when BUILDINGS_ID[:titanium_foundry]
      TitaniumFoundryHelper.get_building_costs(level)
    when BUILDINGS_ID[:hydrogen_tank]
      HydrogenTankHelper.get_building_costs(level)
    when BUILDINGS_ID[:hydrogen_extractor]
      HydrogenExtractorHelper.get_building_costs(level)
    when BUILDINGS_ID[:solar_array]
      SolarArrayHelper.get_building_costs(level)
    when BUILDINGS_ID[:fusion_power_plant]
      FusionPowerPlantHelper.get_building_costs(level)
    when BUILDINGS_ID[:geomorphological_reshaper]
      GeomorphologicalReshaperHelper.get_building_costs(level)
    else
      if BUILDINGS_ID.values.include?(building_id)
        OtherBuildingsHelper.get_building_costs(level, building_id)
      else
        raise ActionController::BadRequest
      end
    end
  end
end
