json.array! @planets do |planet|
  json.extract! planet, :id, :name
  json.is_home planet.user.main_planet_id == planet.id
end