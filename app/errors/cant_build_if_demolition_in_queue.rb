# frozen_string_literal: true

class CantBuildIfDemolitionInQueue < Exception
  def initialize(msg = 'You can not build if demolition in queue')
    super
  end
end
