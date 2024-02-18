# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :set_user

  def show
  end

  def update
    @user.update!(user_params)
    render :show
  end


  private

  ALLOWED_USER_PARAMS = [
    :username,
  ]

  def user_params
    params.require(:user).permit(ALLOWED_USER_PARAMS)
  end

  def set_user
    @user = current_user
  end
end
