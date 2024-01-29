# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CalculationsHelper' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context 'calculations helper' do
    it 'calculate build time in seconds' do
      expect(CalculationsHelper.calculate_build_time_in_seconds(60, 15, 0, 0)).to eq(108)
      expect(CalculationsHelper.calculate_build_time_in_seconds(90, 22, 0, 0)).to eq(161)
      expect(CalculationsHelper.calculate_build_time_in_seconds(135, 33, 0, 0)).to eq(242)
      expect(CalculationsHelper.calculate_build_time_in_seconds(202, 50, 0, 0)).to eq(363)
    end
  end
end
