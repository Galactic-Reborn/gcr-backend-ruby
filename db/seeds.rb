# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if UniverseField.all.empty?
  UniverseField.create_universe
  User.create!(username: 'admin', address: "0x28a95Aa43700dAc5807311ce3680e30068FC6c6d")
end
