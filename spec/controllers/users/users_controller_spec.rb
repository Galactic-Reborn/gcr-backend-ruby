# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  include_examples "basic_seed"

  before do
    @eth_account = Eth::Key.new
    @eth_address = @eth_account.address
  end

  context 'Authorization' do
    context 'login' do
      it 'should correct login user' do
        get '/api/messages', params: { address: @eth_address }
        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        message = response_body['text']
        signed_message = @eth_account.personal_sign(message)

        post '/api/users/sign_in', params: { user: { address: @eth_address, signature: signed_message } }
        expect(response).to have_http_status(:success)
        expect(response.headers['Authorization']).to be_present
      end

      it 'should not login user with wrong signature' do
        get '/api/messages', params: { address: @eth_address }
        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        message = response_body['text']
        signed_message = @eth_account.personal_sign(message)

        post '/api/users/sign_in', params: { user: { address: @eth_address, signature: signed_message + '1' } }
        expect(response).to have_http_status(:unauthorized)
        expect(response.headers['Authorization']).to be_blank
      end

      it 'should not login user with wrong address' do
        get '/api/messages', params: { address: @eth_address }
        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        message = response_body['text']
        signed_message = @eth_account.personal_sign(message)

        post '/api/users/sign_in', params: { user: { address: @eth_address.to_s + '1', signature: signed_message } }
        expect(response).to have_http_status(:unauthorized)
        expect(response.headers['Authorization']).to be_blank
      end

      it 'should not login user with wrong message' do
        get '/api/messages', params: { address: @eth_address }
        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        message = response_body['text']
        signed_message = @eth_account.personal_sign(message + '1')

        post '/api/users/sign_in', params: { user: { address: @eth_address, signature: signed_message } }
        expect(response).to have_http_status(:unauthorized)
        expect(response.headers['Authorization']).to be_blank
      end

      it 'should not create user if no free planet' do
        get '/api/messages', params: { address: @eth_address }
        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        message = response_body['text']
        signed_message = @eth_account.personal_sign(message)

        post '/api/users/sign_in', params: { user: { address: @eth_address, signature: signed_message } }
        expect(response).to have_http_status(:success)
        expect(response.headers['Authorization']).to be_present

        new_account = Eth::Key.new
        get '/api/messages', params: { address: new_account.address }
        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        message = response_body['text']
        signed_message = new_account.personal_sign(message)

        post '/api/users/sign_in', params: { user: { address: new_account.address, signature: signed_message } }
        expect(response).to have_http_status(:success)
        expect(response.headers['Authorization']).to be_present

        Planet.destroy_by(user_id: nil)
        new_account = Eth::Key.new
        get '/api/messages', params: { address: new_account.address }
        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        message = response_body['text']
        signed_message = new_account.personal_sign(message)

        post '/api/users/sign_in', params: { user: { address: new_account.address, signature: signed_message } }
        expect(response).to have_http_status(:bad_request)
        response_body = JSON.parse(response.body)
        expect(response_body['error']).to eq('no free planets')
        expect(response.headers['Authorization']).to be_blank
        expect(User.all.count).to eq(4)
      end
    end
  end

  context 'functionality' do
  end
end
