# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HydrogenExtractorHelper' do

  context 'get building costs' do
    it 'should get correct building costs' do
      expect(HydrogenExtractorHelper.get_building_costs(1)).to eq({:titanium=>225, :auronium=>75, :hydrogen=>0})
      expect(HydrogenExtractorHelper.get_building_costs(2)).to eq({:titanium=>337, :auronium=>112, :hydrogen=>0})
    end
  end

  context 'get production rate' do
    it 'should get correct production rate' do
      expect(HydrogenExtractorHelper.get_production_rate(1, 150)).to eq(8)
      expect(HydrogenExtractorHelper.get_production_rate(2, 150)).to eq(18)
    end

    it 'should get correct production rate with different temperature' do
      expect(HydrogenExtractorHelper.get_production_rate(1, 100)).to eq(10)
      expect(HydrogenExtractorHelper.get_production_rate(2, 100)).to eq(23)
    end
  end

  context 'get energy consumption' do
    it 'should get correct energy consumption' do
      expect(HydrogenExtractorHelper.get_energy_consumption(1)).to eq(22)
      expect(HydrogenExtractorHelper.get_energy_consumption(2)).to eq(48)
    end
  end
end
