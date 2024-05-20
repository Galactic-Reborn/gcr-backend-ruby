# frozen_string_literal: true

class NoBuildingToDemolish < Exception
  def initialize(msg = 'No building to demolish')
    super
  end
end
