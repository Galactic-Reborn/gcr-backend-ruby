json.array! @solar_systems do |solar_system|
  json.extract! solar_system, :pos_galaxy, :pos_system, :pos_planet
  json.planet do
    json.extract! solar_system.planet, :name, :planet_type, :planet_image, :planet_diameter, :temp_max, :temp_min
    if solar_system.planet.user
      json.user do
        json.extract! solar_system.planet.user, :username
      end
    end
  end

end