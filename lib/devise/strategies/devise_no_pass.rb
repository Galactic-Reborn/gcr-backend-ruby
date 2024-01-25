require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class DeviseNoPass < Authenticatable
      def authenticate!
        validation = validate_signature(params[:user][:address], params[:user][:token], params[:user][:signature])
        user = User.find_by_address(params[:user][:address]) if validation
        user ? success!(user) : raise
      end

      def validate_signature(address, token, signature)
        # signer information
        signer_address = address
        # message and signatre (from javascript/metamask)
        message = token
        signature = signature
        # recover the public key from the signature
        recovered_public_key = Eth::Signature.personal_recover message, signature
        # recover the address from the public key
        recovered_address = Eth::Util.public_key_to_address recovered_public_key
        signer_address.eql?(recovered_address.checksummed)
      end
    end
  end
end
