# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auronium RepositoryHelper' do


  context 'get building costs' do
    it 'should get correct building costs' do
      expect(AuroniumRepositoryHelper.get_building_costs(1)).to eq({ :titanium=>1000, :auronium=>500, :hydrogen=>0})
      expect(AuroniumRepositoryHelper.get_building_costs(2)).to eq({ :titanium=>2000, :auronium=>1000, :hydrogen=>0})
    end
  end

  context 'get storage capacity' do
    it 'should get correct storage capacity' do
      expect(AuroniumRepositoryHelper.get_storage_capacity(0)).to eq(10000)
      expect(AuroniumRepositoryHelper.get_storage_capacity(1)).to eq(20000)
      expect(AuroniumRepositoryHelper.get_storage_capacity(2)).to eq(40000)
      expect(AuroniumRepositoryHelper.get_storage_capacity(3)).to eq(80000)
      expect(AuroniumRepositoryHelper.get_storage_capacity(4)).to eq(160000)
    end
  end
end
