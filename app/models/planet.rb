# == Schema Information
#
# Table name: planets
#
#  id                       :uuid             not null, primary key
#  auronium                 :integer
#  auronium_mine_percentage :integer
#  building_demolition      :boolean
#  building_end_time        :integer
#  energy                   :integer
#  energy_max               :integer
#  energy_used              :integer
#  fields_current           :integer
#  fields_max               :integer
#  hangar_plus              :boolean
#  hangar_queue             :json
#  hangar_start_time        :datetime
#  hydrogen                 :integer
#  hydrogen_mine_percentage :integer
#  last_updated             :datetime
#  name                     :string           default("")
#  planet_diameter          :integer
#  planet_image             :string
#  planet_type              :integer
#  stardust                 :integer
#  temp_max                 :integer
#  temp_min                 :integer
#  titanium                 :integer
#  titanium_mine_percentage :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  building_id              :integer
#  user_id                  :uuid
#
# Indexes
#
#  index_planets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Planet < ApplicationRecord
  has_one :user



end
