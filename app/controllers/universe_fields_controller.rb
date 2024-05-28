# frozen_string_literal: true

class UniverseFieldsController < ApplicationController
  before_action :validate_universe_params, only: [:solar_system]

  def solar_system
    @solar_systems = UniverseField.where(pos_galaxy: universe_field_params[:pos_galaxy], pos_system: universe_field_params[:pos_system])
  end

  private

  ALLOWED_UNIVERSE_PARAMS = [
    :pos_galaxy,
    :pos_system,
  ]

  def universe_field_params
    params.require(:universe).permit(ALLOWED_UNIVERSE_PARAMS)
  end

  def validate_universe_params
    missing_params = ALLOWED_UNIVERSE_PARAMS.select { |param| params[:universe][param].blank? }
    raise ActionController::BadRequest unless missing_params.empty?
  end
end
