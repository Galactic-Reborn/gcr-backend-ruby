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
  after_find :check_build_end

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

  def resources_production_rate(planet_avg_temp)
    {
      titanium: TitaniumFoundryHelper.get_production_rate(titanium_foundry),
      auronium: AuroniumSynthesizerHelper.get_production_rate(auronium_synthesizer),
      hydrogen: HydrogenExtractorHelper.get_production_rate(hydrogen_extractor, planet_avg_temp),
    }.freeze
  end

  def energy_consumption
    TitaniumFoundryHelper.get_energy_consumption(titanium_foundry) +
      AuroniumSynthesizerHelper.get_energy_consumption(auronium_synthesizer) +
      HydrogenExtractorHelper.get_energy_consumption(hydrogen_extractor) +
      GeomorphologicalReshaperHelper.get_energy_consumption(geomorphological_reshaper)
  end

  def energy_consumption_by_building(building_id, level)
    case building_id
    when BuildingConstants::BUILDINGS_ID[:titanium_foundry]
      TitaniumFoundryHelper.get_energy_consumption(level)
    when BuildingConstants::BUILDINGS_ID[:auronium_synthesizer]
      AuroniumSynthesizerHelper.get_energy_consumption(level)
    when BuildingConstants::BUILDINGS_ID[:hydrogen_extractor]
      HydrogenExtractorHelper.get_energy_consumption(level)
    when BuildingConstants::BUILDINGS_ID[:geomorphological_reshaper]
      GeomorphologicalReshaperHelper.get_energy_consumption(level)
    else
      0
    end
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

  def requirements(building_id)
    planet_queue = BuildingQueue.new(planet.building_queue)
    actual_building_level = building_level(building_id)
    upgrade_level = calculate_upgrade_level(building_id, actual_building_level, planet_queue)
    requirements = BuildingsHelper.calculate_building_costs(upgrade_level, building_id)
    requirements[:energy] = energy_consumption_by_building(building_id, upgrade_level) - energy_consumption_by_building(building_id, actual_building_level)
    time = CalculationsHelper.calculate_build_time_in_seconds(requirements[:titanium], requirements[:auronium], robotics_workshop, nano_assembly_factory)

    {
      requirements: requirements,
      time: time,
      upgrade_level: upgrade_level,
      level: actual_building_level,
    }
  end

  def all_info
    BuildingConstants::BUILDINGS_ID.values.each_with_object({}) do |building_id, result|
      building_requirements = requirements(building_id)
      building_name = Building.building_name(building_id).underscore.to_sym
      result[building_name] = building_requirements
    end
  end

  def build(building_id)
    planet.check_planet_fields

    planet_queue = BuildingQueue.new(planet.building_queue)
    raise MaxQueue if planet_queue.get_length >= 2

    if planet.building_id == building_id && planet.building_demolition || planet_queue.get_count_by_unit_id_and_is_demolition(building_id, true) > 0
      raise CantBuildIfDemolitionInQueue
    end

    actual_building_level = building_level(building_id)
    upgrade_level = calculate_upgrade_level(building_id, actual_building_level, planet_queue)

    building_costs = BuildingsHelper.calculate_building_costs(upgrade_level, building_id)
    check_resources_availability(building_costs)

    building_time = CalculationsHelper.calculate_build_time_in_seconds(building_costs[:titanium], building_costs[:auronium], robotics_workshop, nano_assembly_factory)

    if planet.building_end_time > 0
      last_queue_item = planet_queue.get_last_queue_item
      if last_queue_item.present?
        building_end_time = last_queue_item['building_end_time']
      else
        building_end_time = planet.building_end_time
      end
      planet_queue.add_queue_item({ amount: 1,
                                    build_time: building_time,
                                    unit_id: building_id,
                                    is_demolition: false,
                                    level: upgrade_level,
                                    level_added_to_queue: upgrade_level,
                                    building_end_time: building_end_time + building_time })
    else
      planet.building_end_time = Time.now.to_i + building_time
      planet.building_demolition = false
      planet.building_id = building_id
      planet.build_time = building_time
      planet.build_level = upgrade_level
    end

    deduct_resources(building_costs)
    planet.building_queue = planet_queue

    planet.save
  end

  def cancel_build(position)
    planet_queue = BuildingQueue.new(planet.building_queue)
    canceled_building_id = 0
    if planet.building_end_time == 0 && planet_queue.get_length == 0
      raise NoBuildingInQueue
    end

    if position == 0 && planet.building_end_time > 0
      unless planet.building_demolition
        building_costs = BuildingsHelper.calculate_building_costs(planet.build_level, planet.building_id)
        refund_resources(building_costs)
      end
      canceled_building_id = planet.building_id
      reset_building
    else
      position -= 1

      queue_item = planet_queue.get_queue_item_by_position(position)
      if queue_item.present?
        unless queue_item['is_demolition']
          building_costs = BuildingsHelper.calculate_building_costs(queue_item['level_added_to_queue'], queue_item['unit_id'])
          refund_resources(building_costs)
        end
        canceled_building_id = queue_item['unit_id']
        planet_queue.remove_queue_item_by_position(position)
      end
    end
    update_queue_times_and_levels(planet_queue)
    if planet_queue.get_length > 0 && planet.building_end_time == 0 && planet.building_id == 0
      process_first_queue_item(planet_queue)
    end
    planet.save
    canceled_building_id
  end

  def demolish(building_id)
    planet_queue = BuildingQueue.new(planet.building_queue)
    raise MaxQueue if planet_queue.get_length >= 2

    if planet.building_id == building_id || planet_queue.get_count_by_unit_id(building_id) > 0
      raise CantDemolishBuildingInQueue
    end

    actual_building_level = building_level(building_id)
    if actual_building_level == 0
      raise NoBuildingToDemolish
    end

    building_costs = BuildingsHelper.calculate_building_costs(actual_building_level, building_id)
    building_time = CalculationsHelper.calculate_build_time_in_seconds(building_costs[:titanium], building_costs[:auronium], robotics_workshop, nano_assembly_factory)

    if planet.building_end_time > 0
      planet_queue.add_queue_item({ amount: 1,
                                    build_time: building_time,
                                    unit_id: building_id,
                                    is_demolition: true,
                                    level: actual_building_level,
                                    level_added_to_queue: actual_building_level,
                                    building_end_time: planet.building_end_time + building_time / 2 })
    else
      planet.building_end_time = Time.now.to_i + building_time / 2
      planet.building_demolition = true
      planet.building_id = building_id
      planet.build_time = building_time / 2
      planet.build_level = actual_building_level
    end

    planet.building_queue = planet_queue
    planet.save
  end

  def check_build_end
    if planet.user_id.present? && planet.building_end_time > 0 && planet.building_end_time <= Time.now.to_i
      planet_queue = BuildingQueue.new(planet.building_queue)
      planet_queue_length = planet_queue.get_length
      building_id = planet.building_id

      if planet.building_demolition
        building_costs = BuildingsHelper.calculate_building_costs(building_level(building_id), building_id)
        self[BuildingConstants::BUILDINGS_NAME[building_id]] -= 1

        planet.titanium += building_costs[:titanium] / 2
        planet.auronium += building_costs[:auronium] / 2
        planet.hydrogen += building_costs[:hydrogen] / 2
      else
        self[BuildingConstants::BUILDINGS_NAME[building_id]] += 1
      end

      if planet_queue_length > 0
        process_first_queue_item(planet_queue)
      else
        reset_building
      end

      planet.building_queue = planet_queue
      planet.save
      self.save
      if planet_queue_length > 0 && planet.building_end_time <= Time.now.to_i
        check_build_end
      end
    end
  end

  private

  def building_level(building_id)
    self[BuildingConstants::BUILDINGS_NAME[building_id]]
  end

  def calculate_upgrade_level(building_id, actual_building_level, planet_queue)
    upgrade_level = actual_building_level + 1
    if planet_queue.get_length > 0 && planet_queue.get_count_by_unit_id(building_id) > 0
      upgrade_level += planet_queue.get_count_by_unit_id(building_id)
    end
    if planet.building_end_time > 0 && planet.building_id == building_id
      upgrade_level += 1
    end
    upgrade_level
  end

  def check_resources_availability(building_costs)
    if planet.titanium < building_costs[:titanium] || planet.auronium < building_costs[:auronium] || planet.hydrogen < building_costs[:hydrogen]
      raise NotEnoughResources
    end
  end

  def deduct_resources(building_costs)
    planet.titanium -= building_costs[:titanium]
    planet.auronium -= building_costs[:auronium]
    planet.hydrogen -= building_costs[:hydrogen]
  end

  def refund_resources(building_costs)
    storages = storages_capacity
    if planet.titanium + building_costs[:titanium] > storages[:titanium]
      planet.titanium = storages[:titanium]
    else
      planet.titanium += building_costs[:titanium]
    end

    if planet.auronium + building_costs[:auronium] > storages[:auronium]
      planet.auronium = storages[:auronium]
    else
      planet.auronium += building_costs[:auronium]
    end

    if planet.hydrogen + building_costs[:hydrogen] > storages[:hydrogen]
      planet.hydrogen = storages[:hydrogen]
    else
      planet.hydrogen += building_costs[:hydrogen]
    end
  end

  def reset_building
    planet.building_end_time = 0
    planet.building_demolition = false
    planet.building_id = 0
    planet.build_time = 0
  end

  def update_queue_times_and_levels(planet_queue)
    previous_unit_id_level = {}

    planet_queue.get_queue.each do |queue_item|
      unit_id = queue_item['unit_id']
      actual_level = planet.building_id == unit_id ? building_level(unit_id) + 1 : building_level(unit_id)
      previous_level = previous_unit_id_level[unit_id] ? previous_unit_id_level[unit_id] : actual_level

      build_time = CalculationsHelper.calculate_build_time_in_seconds(
        BuildingsHelper.calculate_building_costs(previous_level + 1, unit_id)[:titanium],
        BuildingsHelper.calculate_building_costs(previous_level + 1, unit_id)[:auronium],
        robotics_workshop,
        nano_assembly_factory
      )

      queue_item['build_time'] = build_time
      queue_item['level'] = previous_level + 1

      previous_unit_id_level[unit_id] = previous_level + 1
    end
  end

  def process_first_queue_item(planet_queue)
    queue_item = planet_queue.get_first_queue_item
    if queue_item.present?
      planet.building_end_time = Time.now.to_i + queue_item['build_time']
      planet.building_demolition = queue_item['is_demolition']
      planet.building_id = queue_item['unit_id']
      planet.build_time = queue_item['build_time']
      planet.build_level = queue_item['level_added_to_queue']

      planet_queue.remove_queue_item
    end
  end
end
