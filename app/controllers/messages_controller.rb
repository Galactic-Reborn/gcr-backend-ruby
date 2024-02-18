class MessagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_params
  before_action :delete_expired_messages
  before_action :delete_messages_for_address

  def message
    @user_nonce =  nil
    params_address = Eth::Address.new(params[:address])
    if params_address.valid?
      @message = Message.create!(address: params[:address])
    end
  end

  def check_params
    raise ActionController::BadRequest unless params[:address].present?
  end

  def delete_expired_messages
    Message.delete_expired_messages
  end

  def delete_messages_for_address
    Message.delete_messages_for_address(params[:address])
  end
end
