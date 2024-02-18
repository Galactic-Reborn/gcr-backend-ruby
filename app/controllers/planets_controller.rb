# frozen_string_literal: true

class PlanetsController < ApplicationController


  def index
    planet = Planet.find_by(user_id: current_user.id)
    planet.building.build(100)
  end

  def show

  end
end
