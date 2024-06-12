class PlanetsController < ApplicationController
  load_and_authorize_resource :planet
  before_action :add_storage_capacity, only: [:show, :update]
  before_action :production_rates, only: [:show, :update]
  # before_action :update_resources_planet, only: [:show]
  # before_action :update_resources_planets, only: [:index]

  def index
  end

  def show
  end

  def update
    @planet.update!(planet_params)
    render :show
  end

  def home_planet
    @planet = Planet.find_by(id: current_user.main_planet_id)
    production_rates
    add_storage_capacity
    render :show
  end

  def set_as_home
    @planet.set_as_home
    render json: { 'status': 'Home planet was set' }, status: 200
  end

  private

  ALLOWED_PLANET_PARAMS = [
    :name,
  ]

  def planet_params
    params.require(:planet).permit(ALLOWED_PLANET_PARAMS)
  end

  def update_resources_planet
    @planet.update_resources
  end

  def update_resources_planets
    @planets.each(&:update_resources)
  end

  def add_storage_capacity
    @storages_capacity = @planet.building.storages_capacity
  end

  def production_rates
    @production_rates = @planet.building.resources_production_rate(@planet.avg_temp)
  end
end
