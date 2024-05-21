# frozen_string_literal: true

require 'rails_helper'


RSpec.describe 'FusionPowerPlantHelper' do

  context 'get building costs' do
    it 'should get correct building costs' do
      expect(FusionPowerPlantHelper.get_building_costs(1)).to eq({:titanium=>900, :auronium=>360, :hydrogen=>180})
      expect(FusionPowerPlantHelper.get_building_costs(2)).to eq({:titanium=>1620, :auronium=>648, :hydrogen=>324})
    end
  end

  context 'get production rate' do
    it 'should get correct production rate' do
      expect(FusionPowerPlantHelper.get_production_rate(1)).to eq(33)
      expect(FusionPowerPlantHelper.get_production_rate(2)).to eq(72)
    end
  end

  context 'get hydrogen consumption' do
    it 'should get correct hydrogen consumption' do
      expect(FusionPowerPlantHelper.get_hydrogen_consumption(1)).to eq(11)
      expect(FusionPowerPlantHelper.get_hydrogen_consumption(2)).to eq(24)
    end
  end
end
