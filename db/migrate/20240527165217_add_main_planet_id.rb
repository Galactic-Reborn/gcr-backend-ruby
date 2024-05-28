class AddMainPlanetId < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :main_planet, foreign_key: { to_table: :planets }, type: :uuid
  end
end
