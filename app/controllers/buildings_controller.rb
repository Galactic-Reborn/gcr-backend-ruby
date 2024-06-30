# frozen_string_literal: true

class BuildingsController < ApplicationController
  load_and_authorize_resource :planet
  load_and_authorize_resource :building, through: :planet, singleton: true

  def index
  end

  def build
    @building.build(building_params[:id].to_i)
    @requirements = @building.requirements(building_params[:id].to_i)
  end

  def cancel
    canceled_building_id = @building.cancel_build(cancel_params[:position].to_i)
    @requirements = @building.requirements(canceled_building_id)
    render :build
  end

  def demolish
    @building.demolish(building_params[:id].to_i)
    @requirements = @building.requirements(building_params[:id].to_i)
    render :build
  end

  private

  def check_build_end
    @building.check_build_end
  end

  def building_params
    params.require(:building).permit(:id)
  end

  def cancel_params
    params.require(:queue).permit(:position)
  end

end
