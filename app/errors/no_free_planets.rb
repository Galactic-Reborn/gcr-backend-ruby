# frozen_string_literal: true

class NoFreePlanets < StandardError
  def initialize(msg = 'No free planets')
    super
  end
end
