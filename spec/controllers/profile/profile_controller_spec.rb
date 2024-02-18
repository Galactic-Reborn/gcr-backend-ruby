# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProfileController', type: :request do
  include_examples "basic_seed"

  context 'functionality' do

    context 'fetch' do
      it 'should return the current user profile' do
        get '/api/profile', headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_profile')

        get '/api/profile', headers: auth_as(milosz)
        expect(response).to match_snapshot('milosz_profile')
      end
    end

    context 'update' do
      it 'should update the current user profile' do
        put '/api/profile', params: load_request("update_profile"), headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_profile_update')
      end
    end
  end
end
