# frozen_string_literal: true

# == Schema Information
#
# Table name: universe_fields
#
#  id         :uuid             not null, primary key
#  pos_galaxy :integer
#  pos_planet :integer
#  pos_system :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  planet_id  :uuid
#
# Indexes
#
#  index_universe_fields_on_planet_id  (planet_id)
#
# Foreign Keys
#
#  fk_rails_...  (planet_id => planets.id)
#
require 'rails_helper'

RSpec.describe UniverseField, type: :model do

  describe 'create_universe' do
    it 'create the universe' do
      UniverseField.create_universe
      expect(UniverseField.count).to eq(GameConfig::GALAXIES * GameConfig::SOLAR_SYSTEM_PER_GALAXY * GameConfig::PLANETS_PER_SOLAR_SYSTEM)
    end
  end
end
