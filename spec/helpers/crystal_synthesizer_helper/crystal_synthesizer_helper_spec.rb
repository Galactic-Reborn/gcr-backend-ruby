# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CrystalSynthesizerHelper' do


  context 'get building costs' do
    it 'should get correct building costs' do
      expect(CrystalSynthesizerHelper.get_building_costs(1)).to eq({:titanium=>48, :crystal=>24, :hydrogen=>0})
      expect(CrystalSynthesizerHelper.get_building_costs(2)).to eq({:titanium=>76, :crystal=>38, :hydrogen=>0})
    end
  end

  context 'get production rate' do
    it 'should get correct production rate' do
      expect(CrystalSynthesizerHelper.get_production_rate(1)).to eq(22)
      expect(CrystalSynthesizerHelper.get_production_rate(2)).to eq(48)
    end
  end

  context 'get energy consumption' do
    it 'should get correct energy consumption' do
      expect(CrystalSynthesizerHelper.get_energy_consumption(1)).to eq(11)
      expect(CrystalSynthesizerHelper.get_energy_consumption(2)).to eq(24)
    end
  end
end