# frozen_string_literal: true

class NotEnoughResources < StandardError
  def initialize(msg = 'Not enough resources')
    super
  end
end
