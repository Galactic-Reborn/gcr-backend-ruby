class MessagesController < ApplicationController
  before_action :check_params

  def message
    @user_nonce =  nil
    params_address = Eth::Address.new(params[:address])
    if params_address.valid?
      user = User.find_by(address: params_address.to_s)
      if user.present?
        @user_nonce = SecureRandom.hex(32)
        user.update(nonce: @user_nonce)
      end
    end
  end

  def check_params
    raise ActionController::BadRequest unless params[:address].present?
  end
end
