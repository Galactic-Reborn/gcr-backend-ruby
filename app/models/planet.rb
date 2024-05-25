# == Schema Information
#
# Table name: planets
#
#  id                  :uuid             not null, primary key
#  auronium            :integer
#  building_demolition :boolean
#  building_end_time   :integer
#  building_queue      :json
#  energy              :integer
#  energy_max          :integer
#  energy_used         :integer
#  fields_current      :integer
#  fields_max          :integer
#  hangar_plus         :boolean
#  hangar_queue        :json
#  hangar_start_time   :datetime
#  hydrogen            :integer
#  last_updated        :integer          default(0)
#  name                :string           default("")
#  planet_diameter     :integer
#  planet_image        :string
#  planet_type         :integer
#  stardust            :integer
#  temp_max            :integer
#  temp_min            :integer
#  titanium            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  building_id         :integer
#  universe_field_id   :uuid
#  user_id             :uuid
#
# Indexes
#
#  index_planets_on_universe_field_id  (universe_field_id)
#  index_planets_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (universe_field_id => universe_fields.id)
#  fk_rails_...  (user_id => users.id)
#
class Planet < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :universe_field, optional: true
  has_one :building, dependent: :destroy
  before_validation :defaults

  after_find :update_resources

  def avg_temp
    (temp_max + temp_min) / 2
  end

  def update_resources
    production_rates = building.resources_production_rate(avg_temp)
    energy_production_solar = building.energy_production_solar
    energy_production_fusion = building.energy_production_fusion
    energy_consumption = building.energy_consumption
    hydrogen_consumption = building.hydrogen_consumption
    storages_capacity = building.storages_capacity

    time_difference = Time.now.to_i - last_updated

    titanium_produced = BuildingsHelper.get_produced_resources(production_rates[:titanium], time_difference)
    crystal_produced = BuildingsHelper.get_produced_resources(production_rates[:auronium], time_difference)
    hydrogen_produced = BuildingsHelper.get_produced_resources(production_rates[:hydrogen], time_difference)
    hydrogen_consumed = BuildingsHelper.get_produced_resources(hydrogen_consumption, time_difference)

    if hydrogen_consumed > hydrogen + hydrogen_produced
      energy_production_fusion = 0
    end

    energy_produced = energy_production_solar + energy_production_fusion

    if energy_produced < energy_consumption
      mines_efficiency = energy_produced.fdiv(energy_consumption)
      titanium_produced = (titanium_produced * mines_efficiency).floor
      crystal_produced = (crystal_produced * mines_efficiency).floor
      hydrogen_produced = (hydrogen_produced * mines_efficiency).floor
    end

    self.titanium = [self.titanium + titanium_produced, storages_capacity[:titanium]].min
    self.auronium = [self.auronium + crystal_produced, storages_capacity[:auronium]].min
    self.hydrogen = [self.hydrogen + hydrogen_produced - hydrogen_consumed, storages_capacity[:hydrogen]].min

    self.energy_max = energy_produced
    self.energy_used = energy_consumption > energy_produced ? energy_produced : energy_consumption
    self.energy = energy_max - energy_used
    self.fields_current = sum_of_buildings_levels

    self.last_updated = Time.now.to_i

    self.save
  end

  def resources
    {
      titanium: titanium,
      auronium: auronium,
      hydrogen: hydrogen,
    }.freeze
  end

  def check_planet_fields
    raise PlanetFieldsFull if fields_current + 1 >= fields_max
  end

  def sum_of_buildings_levels
    building.attributes.except('id', 'created_at', 'updated_at', 'planet_id').values.compact.sum
  end

  def self.get_first_free_planet
    Planet.where(user_id: nil).joins(:universe_field)
          .where(universe_fields: { pos_planet: GameConfig::MIN_POSITION_USER_START_PLANET..GameConfig::MAX_POSITION_USER_START_PLANET })
          .order(:created_at)
          .first
  end

  private

  def defaults
    self.building_end_time ||= 0
  end

end
