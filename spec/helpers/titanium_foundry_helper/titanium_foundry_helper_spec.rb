# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TitaniumFoundryHelper' do

  context 'get building costs' do
    it 'should get correct building costs' do
      expect(TitaniumFoundryHelper.get_building_costs(1)).to eq({:titanium=>60, :crystal=>15, :hydrogen=>0})
      expect(TitaniumFoundryHelper.get_building_costs(2)).to eq({:titanium=>90, :crystal=>22, :hydrogen=>0})
    end
  end

  context 'get production rate' do
    it 'should get correct production rate' do
      expect(TitaniumFoundryHelper.get_production_rate(0)).to eq(0)
      expect(TitaniumFoundryHelper.get_production_rate(1)).to eq(33)
      expect(TitaniumFoundryHelper.get_production_rate(2)).to eq(72)
      expect(TitaniumFoundryHelper.get_production_rate(3)).to eq(119)
      expect(TitaniumFoundryHelper.get_production_rate(4)).to eq(175)
    end
  end

  context 'get energy consumption' do
    it 'should get correct energy consumption' do
      expect(TitaniumFoundryHelper.get_energy_consumption(0)).to eq(0)
      expect(TitaniumFoundryHelper.get_energy_consumption(1)).to eq(11)
      expect(TitaniumFoundryHelper.get_energy_consumption(2)).to eq(24)
      expect(TitaniumFoundryHelper.get_energy_consumption(3)).to eq(39)
      expect(TitaniumFoundryHelper.get_energy_consumption(4)).to eq(58)
    end
  end
end
