# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SolarArrayHelper' do

  context 'get building costs' do
    it 'should get correct building costs' do
      expect(SolarArrayHelper.get_building_costs(1)).to eq({:titanium=>75, :auronium=>30, :hydrogen=>0})
      expect(SolarArrayHelper.get_building_costs(2)).to eq({:titanium=>112, :auronium=>45, :hydrogen=>0})
    end
  end

  context 'get energy production' do
    it 'should get correct energy production' do
      expect(SolarArrayHelper.get_production_rate(0)).to eq(0)
      expect(SolarArrayHelper.get_production_rate(1)).to eq(22)
      expect(SolarArrayHelper.get_production_rate(2)).to eq(48)
      expect(SolarArrayHelper.get_production_rate(3)).to eq(79)
      expect(SolarArrayHelper.get_production_rate(4)).to eq(117)
    end
  end
end
