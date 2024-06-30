json.requirements do
  json.extract! @requirements, :requirements, :time, :upgrade_level, :level
end

json.planet do
  json.partial! 'planets/planet_building_info', planet: @planet

  json.resources do
    json.partial! 'planets/resources', planet: @planet,
                  production_rates: @planet.building.resources_production_rate(@planet.avg_temp),
                  storages_capacity: @planet.building.storages_capacity
  end
end
