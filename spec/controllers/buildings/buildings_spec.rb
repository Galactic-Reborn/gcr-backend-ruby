# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Buildings', type: :request do
  include_examples "basic_seed"

  context 'authorization' do
    it 'crud' do
      check_authorization(:get, "/api/planets/#{adrian_planet.id}/buildings", milosz)
      check_authorization(:get, "/api/planets/#{milosz_planet.id}/buildings", adrian)

      check_authorization(:post, "/api/planets/#{adrian_planet.id}/buildings/build", milosz, { building: { id: 100 } })
      check_authorization(:post, "/api/planets/#{milosz_planet.id}/buildings/build", adrian, { building: { id: 100 } })

      check_authorization(:post, "/api/planets/#{adrian_planet.id}/buildings/cancel", milosz, { queue: { position: 0 } })
      check_authorization(:post, "/api/planets/#{milosz_planet.id}/buildings/cancel", adrian, { queue: { position: 0 } })

      check_authorization(:post, "/api/planets/#{adrian_planet.id}/buildings/demolish", milosz, { building: { id: 100 } })
      check_authorization(:post, "/api/planets/#{milosz_planet.id}/buildings/demolish", adrian, { building: { id: 100 } })
    end
  end

  context 'functionality' do
    it 'fetch' do
      get "/api/planets/#{adrian_planet.id}/buildings", headers: auth_as(adrian)
      expect(response).to match_snapshot('adrian_buildings')

      get "/api/planets/#{milosz_planet.id}/buildings", headers: auth_as(milosz)
      expect(response).to match_snapshot('milosz_buildings')
    end

    context 'build' do
      it 'should start building' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_building')

        expect(Planet.find(adrian_planet.id).building_id).to eq(100)
      end

      it 'should return error if not enough resources' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 110 } }
        expect(response).to match_snapshot('build_not_enough_resources')
      end

      it 'should return error if max queue length reached' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('build_max_queue_length_reached')
      end
    end

    context 'cancel' do
      it 'should cancel building' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_building')

        expect(Planet.find(adrian_planet.id).building_id).to eq(100)

        post "/api/planets/#{adrian_planet.id}/buildings/cancel", headers: auth_as(adrian), params: { queue: { position: 0 } }
        expect(response).to match_snapshot('cancel_building')

        expect(Planet.find(adrian_planet.id).building_id).to eq(0)
      end

      it 'should return error if no building in queue' do
        post "/api/planets/#{adrian_planet.id}/buildings/cancel", headers: auth_as(adrian), params: { queue: { position: 0 } }
        expect(response).to match_snapshot('build_cancel_no_building_in_queue')
      end
    end
    context 'demolish' do
      it 'should start demolishing' do
        post "/api/planets/#{adrian_planet.id}/buildings/demolish", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_demolishing')

        expect(Planet.find(adrian_planet.id).building_id).to eq(100)
        expect(Planet.find(adrian_planet.id).building_demolition).to eq(true)
      end
      it 'should not demolish if building is in queue' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        post "/api/planets/#{adrian_planet.id}/buildings/demolish", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('build_demolish_building_in_queue')
      end

      it 'should not demolish if building has level 0' do
        post "/api/planets/#{adrian_planet.id}/buildings/demolish", headers: auth_as(adrian), params: { building: { id: 115 } }
        expect(response).to match_snapshot('build_demolish_building_level_0')
      end
    end

    context 'check_build_end' do
      it 'should update building to level 2' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_building')

        get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_planet_after_start_building_id_100_to_level_2')

        allow(Time).to receive(:now).and_return(Time.now + 3.minutes)

        get "/api/planets/#{adrian_planet.id}/buildings", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_buildings_update_building_to_level_2')
      end

      it 'should update building to level 3' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_building')

        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_building')

        get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_planet_after_start_building_id_100_to_level_3')

        allow(Time).to receive(:now).and_return(Time.now + 3.minutes)

        get "/api/planets/#{adrian_planet.id}/buildings", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_buildings_after_end_building_id_100_to_level_2')

        allow(Time).to receive(:now).and_return(Time.now + 6.minutes)

        get "/api/planets/#{adrian_planet.id}/buildings", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_buildings_after_end_building_id_100_to_level_3')
      end

      it 'should update build id 100 to 2 and build id 101 to 2' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_building')

        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 101 } }
        expect(response).to match_snapshot('start_building')

        get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_planet_after_start_building_id_100_and_101_to_level_2')

        allow(Time).to receive(:now).and_return(Time.now + 3.minutes)

        get "/api/planets/#{adrian_planet.id}/buildings", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_buildings_after_end_building_id_100_to_level_2')

        allow(Time).to receive(:now).and_return(Time.now + 6.minutes)

        get "/api/planets/#{adrian_planet.id}/buildings", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_buildings_after_end_building_id_101_level_2_and_id_100_to_level_2')
      end

      it 'should cancel last building with id 100 in queue' do
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 101 } }
        post "/api/planets/#{adrian_planet.id}/buildings/build", headers: auth_as(adrian), params: { building: { id: 100 } }

        get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_planet_after_start_building_id_100_to_level_3_and_id_101_to_level_2')

        post "/api/planets/#{adrian_planet.id}/buildings/cancel", headers: auth_as(adrian), params: { queue: { position: 2 } }
        expect(response).to match_snapshot('cancel_building')

        get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_planet_after_cancel_building_id_100_in_queue')
      end

      it 'should demolish building with id 100' do
        post "/api/planets/#{adrian_planet.id}/buildings/demolish", headers: auth_as(adrian), params: { building: { id: 100 } }
        expect(response).to match_snapshot('start_demolishing')

        get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_planet_after_start_demolishing_building_id_100')

        allow(Time).to receive(:now).and_return(Time.now + 3.minutes)

        get "/api/planets/#{adrian_planet.id}/buildings", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_buildings_after_end_demolishing_building_id_100')

        get "/api/planets/#{adrian_planet.id}", headers: auth_as(adrian)
        expect(response).to match_snapshot('adrian_planet_after_end_demolishing_building_id_100')
      end

    end
  end
end
