# frozen_string_literal: true

require 'rails_helper'


RSpec.describe 'PlanetsController', type: :request do
  include_examples "basic_seed"

  context 'authorization' do
    it 'fetch' do
      check_authorization(:get, "/api/planets/#{adrian_planet.id}", milosz)
      check_authorization(:get, "/api/planets/#{milosz_planet.id}", adrian)
    end
  end

  context 'functionality' do
    it 'fetch' do
      get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
      expect(response).to match_snapshot('adrian_planet')

      get "/api/planets/#{milosz_planet.id}", headers: auth_as(milosz)
      expect(response).to match_snapshot('milosz_planet')

      get '/api/planets', headers: auth_as(adrian)
      expect(response).to match_snapshot('adrian_planets')

      get '/api/planets', headers: auth_as(milosz)
      expect(response).to match_snapshot('milosz_planets')
    end

    it 'update_resources' do
      get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
      expect(response).to match_snapshot('adrian_planet')

      allow(Time).to receive(:now).and_return(Time.now + 1.hours)
      get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
      expect(response).to match_snapshot('adrian_planet_update_resources')
    end
  end
end
