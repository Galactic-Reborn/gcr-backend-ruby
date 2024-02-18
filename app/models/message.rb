# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  address    :string           default(""), not null
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Message < ApplicationRecord
  before_validation :set_defaults

  def self.delete_expired_messages
    Message.where('created_at < ?', 5.minutes.ago).delete_all
  end

  def self.delete_messages_for_address(address)
    Message.where(address: address).delete_all
  end


  private

  def set_defaults
    self.text ||= "Sign this message to prove you are owner of this account.\n Nonce: #{SecureRandom.hex(32)}"
  end


end
