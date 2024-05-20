# frozen_string_literal: true

class BuildingsController < ApplicationController
  load_and_authorize_resource :planet
  load_and_authorize_resource :building, through: :planet, singleton: true
  before_action :check_build_end

  def index
  end

  def build
    @building.build(building_params[:id].to_i)
    render json: { 'status': 'Start building' }, status: 200
  end

  def cancel
    @building.cancel_build(cancel_params[:position].to_i)
    render json: { 'status': 'Building canceled' }, status: 200
  end

  def demolish
    @building.demolish(building_params[:id].to_i)
    render json: { 'status': 'Start demolishing' }, status: 200
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
