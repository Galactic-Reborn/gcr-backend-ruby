# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UniverseFields', type: :request do
  include_examples "basic_seed"

  context 'authorization' do
    it 'fetch' do
      get '/api/universe/solar_system'
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'functionality' do
    context 'solar_system' do
      it 'should return all solar systems' do
        get '/api/universe/solar_system', headers: auth_as(adrian), params: { universe: { pos_galaxy: 1, pos_system: 1 } }
        expect(response).to match_snapshot('solar_system_1_1')
      end

      it 'should return all solar systems' do
        get '/api/universe/solar_system', headers: auth_as(milosz), params: { universe: { pos_galaxy: 1, pos_system: 2 } }
        expect(response).to match_snapshot('solar_system_1_2')
      end

      it 'should return all solar systems' do
        get '/api/universe/solar_system', headers: auth_as(adrian), params: { universe: { pos_galaxy: 2, pos_system: 1 } }
        expect(response).to match_snapshot('solar_system_2_1')
      end
    end
  end
end
