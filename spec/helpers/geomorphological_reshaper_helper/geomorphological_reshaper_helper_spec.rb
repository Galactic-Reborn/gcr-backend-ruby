# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GeomorphologicalReshaperHelper' do


  context 'get building costs' do
    it  'should return correct building costs' do
      expect(GeomorphologicalReshaperHelper.get_building_costs(1)).to eq({:titanium=>0, :crystal=>50000, :hydrogen=>100000})
      expect(GeomorphologicalReshaperHelper.get_building_costs(2)).to eq({:titanium=>0, :crystal=>100000, :hydrogen=>200000})
    end
  end

  context 'get energy consumption' do
    it 'should return correct energy consumption' do
      expect(GeomorphologicalReshaperHelper.get_energy_consumption(1)).to eq(1000)
      expect(GeomorphologicalReshaperHelper.get_energy_consumption(2)).to eq(2000)
    end
  end
end
