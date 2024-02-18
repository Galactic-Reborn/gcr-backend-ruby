# frozen_string_literal: true

# == Schema Information
#
# Table name: buildings
#
#  id                          :uuid             not null, primary key
#  advanced_research_institute :integer          default(0)
#  aerospace_yard              :integer          default(0)
#  auronium_repository         :integer          default(0)
#  auronium_synthesizer        :integer          default(0)
#  fusion_power_plant          :integer          default(0)
#  geomorphological_reshaper   :integer          default(0)
#  hydrogen_extractor          :integer          default(0)
#  hydrogen_tank               :integer          default(0)
#  lunar_mine                  :integer          default(0)
#  missile_silo                :integer          default(0)
#  nano_assembly_factory       :integer          default(0)
#  robotics_workshop           :integer          default(0)
#  solar_array                 :integer          default(0)
#  star_ship_hangar            :integer          default(0)
#  titanium_depot              :integer          default(0)
#  titanium_foundry            :integer          default(0)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  planet_id                   :uuid             not null
#
# Indexes
#
#  index_buildings_on_planet_id  (planet_id)
#
# Foreign Keys
#
#  fk_rails_...  (planet_id => planets.id)
#
class Building < ApplicationRecord
  belongs_to :planet

  def self.building_cost(building_id)
    BuildingConstants::BUILDINGS_COSTS[building_id]
  end

  def self.building_name(building_id)
    BuildingConstants::BUILDINGS_NAME[building_id]
  end

  def self.building_id(building_name)
    BuildingConstants::BUILDINGS_ID[building_name]
  end

  def storages_capacity
    {
      titanium: TitaniumDepotHelper.get_storage_capacity(titanium_depot),
      auronium: AuroniumRepositoryHelper.get_storage_capacity(auronium_repository),
      hydrogen: HydrogenTankHelper.get_storage_capacity(hydrogen_tank),
    }.freeze
  end

  def resources_production_rate
    {
      titanium: TitaniumFoundryHelper.get_production_rate(titanium_foundry),
      auronium: AuroniumSynthesizerHelper.get_production_rate(auronium_synthesizer),
      hydrogen: HydrogenExtractorHelper.get_production_rate(hydrogen_extractor, planet.avg_temp),
    }.freeze
  end

  def energy_consumption
    TitaniumFoundryHelper.get_energy_consumption(titanium_foundry) +
      AuroniumSynthesizerHelper.get_energy_consumption(auronium_synthesizer) +
      HydrogenExtractorHelper.get_energy_consumption(hydrogen_extractor) +
      GeomorphologicalReshaperHelper.get_energy_consumption(geomorphological_reshaper)
  end

  def energy_production_solar
    SolarArrayHelper.get_production_rate(solar_array)
  end

  def energy_production_fusion
    FusionPowerPlantHelper.get_production_rate(fusion_power_plant)
  end

  def hydrogen_consumption
    FusionPowerPlantHelper.get_hydrogen_consumption(fusion_power_plant)
  end

  def build(building_id)
    # Sprawdzanie dostępności pól na planecie
    planet.check_planet_fields

    # Inicjalizacja kolejki budowy
    planet_queue = BuildingQueue.new(planet.building_queue)
    raise MaxQueue if planet_queue.get_length >= 2

    # Określenie aktualnego poziomu budynku i planowanego poziomu ulepszenia
    actual_building_level = self[BuildingConstants::BUILDINGS_NAME[building_id]]
    upgrade_level = actual_building_level + 1

    # Logika dotycząca ulepszenia w kolejce
    if planet_queue.get_length > 0 && planet_queue.get_count_by_unit_id(building_id) > 0
      upgrade_level += planet_queue.get_count_by_unit_id(building_id)
    elsif planet.building_end_time > 0 && planet_queue.get_length == 0 && planet.building_id == building_id
      upgrade_level += 1
    end

    # Obliczanie kosztów budowy
    building_costs = BuildingsHelper.calculate_building_costs(upgrade_level, building_id)
    if planet.titanium < building_costs[:titanium] || planet.auronium < building_costs[:auronium] || planet.hydrogen < building_costs[:hydrogen]
      raise NotEnoughResources
    end

    # Obliczanie czasu budowy
    building_time = CalculationsHelper.calculate_build_time_in_seconds(building_costs[:titanium], building_costs[:auronium], robotics_workshop, nano_assembly_factory)

    # Dodawanie do kolejki lub rozpoczęcie budowy
    if planet.building_end_time > 0
      planet_queue.add_queue_item({ amount: 1, unit_id: building_id, is_demolition: false })
    else
      planet.building_end_time = Time.now.to_i + building_time
      planet.building_demolition = false
      planet.building_id = building_id
    end

    # Odejmowanie zasobów i zapisanie zmian
    planet.titanium -= building_costs[:titanium]
    planet.auronium -= building_costs[:auronium]
    planet.hydrogen -= building_costs[:hydrogen]
    planet.building_queue = planet_queue

    planet.save
  end

end
