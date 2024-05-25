json.extract! @planet,
              :id,
              :auronium,
              :building_demolition,
              :building_end_time,
              :building_queue,
              :building_id,
              :energy,
              :energy_max,
              :energy_used,
              :fields_current,
              :fields_max,
              :hangar_plus,
              :hangar_queue,
              :hangar_start_time,
              :hydrogen,
              :last_updated,
              :name,
              :planet_diameter,
              :planet_image,
              :planet_type,
              :stardust,
              :temp_max,
              :temp_min,
              :titanium

json.titanium_storage @storages_capacity[:titanium]
json.auronium_storage @storages_capacity[:auronium]
json.hydrogen_storage @storages_capacity[:hydrogen]