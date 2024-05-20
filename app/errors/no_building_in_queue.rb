# frozen_string_literal: true

class NoBuildingInQueue < Exception
  def initialize(msg = 'No building in queue')
    super
  end
end
