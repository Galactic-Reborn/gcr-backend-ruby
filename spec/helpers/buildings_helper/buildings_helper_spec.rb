# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BuildingsHelper' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context 'buildings helper' do
    it 'should get correct building' do
      expect(BuildingsHelper.get_base_building_costs(BuildingConstants::BUILDINGS_ID[:titaniumFoundry])).to eq({:titanium=>60, :crystal=>15, :hydrogen=>0,:energy=>0 , :factor=>1.5})
    end
  end
end
