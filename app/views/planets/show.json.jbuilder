json.extract! @planet,
              :id,
              :hangar_plus,
              :hangar_queue,
              :hangar_start_time,
              :last_updated,
              :planet_image,
              :stardust

json.partial! 'planets/planet_building_info', planet: @planet

json.planet_info do
  json.extract! @planet,
                :name,
                :planet_type,
                :planet_diameter,
                :temp_max,
                :temp_min,
                :fields_current,
                :fields_max
  json.coordinates @planet.coordinates
end

json.buildings do
  json.extract! @planet.building.all_info, :titanium_foundry, :titanium_depot,
                :auronium_synthesizer, :hydrogen_extractor, :auronium_repository, :solar_array, :fusion_power_plant,
                :advanced_research_institute, :geomorphological_reshaper, :hydrogen_tank, :star_ship_hangar, :missile_silo,
                :aerospace_yard, :lunar_mine, :robotics_workshop, :nano_assembly_factory
end

json.resources do
  json.partial! 'planets/resources', planet: @planet,
                production_rates: @planet.building.resources_production_rate(@planet.avg_temp),
                storages_capacity: @planet.building.storages_capacity
end