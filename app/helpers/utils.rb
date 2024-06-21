# frozen_string_literal: true

module Utils
  extend self

  def shot_eth_address(eth_address)
    eth_address[0..5] + '...' + eth_address[-5..-1]
  end
end
