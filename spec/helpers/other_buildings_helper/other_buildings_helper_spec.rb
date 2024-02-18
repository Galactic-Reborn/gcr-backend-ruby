# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OtherBuildingsHelper' do

  context 'get building costs' do
    it 'should get correct building costs' do
      expect(OtherBuildingsHelper.get_building_costs(1, BuildingConstants::BUILDINGS_ID[:robotics_workshop])).to eq({ :titanium=>400, :crystal=>120, :hydrogen=>200})
      expect(OtherBuildingsHelper.get_building_costs(2, BuildingConstants::BUILDINGS_ID[:robotics_workshop])).to eq({ :titanium=>800, :crystal=>240, :hydrogen=>400})

      expect(OtherBuildingsHelper.get_building_costs(1, BuildingConstants::BUILDINGS_ID[:nano_assembly_factory])).to eq({ :titanium=>1000000, :crystal=>500000, :hydrogen=>100000})
      expect(OtherBuildingsHelper.get_building_costs(2, BuildingConstants::BUILDINGS_ID[:nano_assembly_factory])).to eq({ :titanium=>2000000, :crystal=>1000000, :hydrogen=>200000})
    end
  end
end
