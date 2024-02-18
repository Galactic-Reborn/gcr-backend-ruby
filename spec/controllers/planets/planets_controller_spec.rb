# frozen_string_literal: true

require 'rails_helper'


RSpec.describe 'PlanetsController', type: :request do
  include_examples "basic_seed"

  context 'test' do
    it 'succeeds' do
      get '/api/planets',  headers: auth_as(adrian)
      get '/api/planets',  headers: auth_as(adrian)
      get '/api/planets',  headers: auth_as(adrian)
      get '/api/planets',  headers: auth_as(adrian)
      get '/api/planets',  headers: auth_as(adrian)
    end
  end
end
