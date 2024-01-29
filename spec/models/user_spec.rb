# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  address             :string           default(""), not null
#  current_sign_in_at  :datetime
#  current_sign_in_ip  :string
#  encrypted_password  :string           default(""), not null
#  last_sign_in_at     :datetime
#  last_sign_in_ip     :string
#  nonce               :string
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  tech_end_time       :integer
#  username            :string           default(""), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tech_id             :integer
#
# Indexes
#
#  index_users_on_address  (address) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
