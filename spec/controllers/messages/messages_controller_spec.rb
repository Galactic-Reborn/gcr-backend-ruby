# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MessagesController' , type: :request do

  before do
    @eth_account = Eth::Key.new
    @eth_address = @eth_account.address

    @eth_account_second = Eth::Key.new
    @eth_address_second = @eth_account_second.address
  end

  context 'Authorization' do
    it 'should not require authorization for messages' do
      check_no_authorization(:get, '/api/messages', { address: @eth_address })
    end
  end

  context 'functionality' do
    context 'message' do
      it 'should delete all messages for address' do
        Message.create!(address: @eth_address)
        Message.create!(address: @eth_address)
        Message.create!(address: @eth_address)
        Message.create!(address: @eth_address)
        Message.create!(address: @eth_address)
        expect(Message.all.count).to eq(5)
        get '/api/messages', params: { address: @eth_address }
        expect(Message.all.count).to eq(1)
      end

      it 'deletes messages older than 5 minutes' do
        Message.create!(created_at: 6.minutes.ago ,address: @eth_account_second)
        Message.create!(created_at: 4.minutes.ago, address: @eth_account_second)
        expect(Message.all.count).to eq(2)
        get '/api/messages', params: { address: @eth_address }
        expect(Message.all.count).to eq(2)
      end

      it 'does not delete messages that are exactly 5 minutes old' do
        Message.create!(created_at: 5.minutes.ago, address: @eth_account_second)
        expect(Message.all.count).to eq(1)
        get '/api/messages', params: { address: @eth_address }
        expect(Message.all.count).to eq(1)
      end

      it 'does not delete messages that are less than 5 minutes old' do
        Message.create!(created_at: 3.minutes.ago ,address: @eth_account_second)
        expect(Message.all.count).to eq(1)
        get '/api/messages', params: { address: @eth_address }
        expect(Message.all.count).to eq(2)
      end
    end
  end
end
