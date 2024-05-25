class PlanetsController < ApplicationController
  load_and_authorize_resource :planet
  # before_action :update_resources_planet, only: [:show]
  # before_action :update_resources_planets, only: [:index]

  def index
  end

  def show
    @storages_capacity = @planet.building.storages_capacity
  end

  private

  def update_resources_planet
    @planet.update_resources
  end

  def update_resources_planets
    @planets.each(&:update_resources)
  end
end
