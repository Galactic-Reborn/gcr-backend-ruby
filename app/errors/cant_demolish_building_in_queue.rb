# frozen_string_literal: true

class CantDemolishBuildingInQueue < Exception
  def message
    'You can not demolish building in queue'
  end
end
