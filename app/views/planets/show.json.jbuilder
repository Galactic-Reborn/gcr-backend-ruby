json.extract! @planet,
              :id,
              :building_demolition,
              :building_end_time,
              :building_queue,
              :building_id,
              :hangar_plus,
              :hangar_queue,
              :hangar_start_time,
              :last_updated,
              :planet_image,
              :stardust

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

json.resources do
  json.energy do
    json.used @planet.energy_used
    json.max @planet.energy_max
    json.free @planet.energy_max - @planet.energy_used
  end
  json.titanium do
    json.amount @planet.titanium
    json.production @production_rates[:titanium]
    json.storage @storages_capacity[:titanium]
  end
  json.auronium do
    json.amount @planet.auronium
    json.production @production_rates[:auronium]
    json.storage @storages_capacity[:auronium]
  end
  json.hydrogen do
    json.amount @planet.hydrogen
    json.production @production_rates[:hydrogen]
    json.storage @storages_capacity[:hydrogen]
  end
end