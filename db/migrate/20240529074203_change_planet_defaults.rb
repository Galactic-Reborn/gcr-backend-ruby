class ChangePlanetDefaults < ActiveRecord::Migration[7.1]
  def change
    change_column_default :planets, :building_id, from: nil, to: 0
    change_column_default :planets, :hangar_plus, from: nil, to: false
    change_column_default :planets, :building_end_time, from: nil, to: 0
    change_column_default :planets, :building_demolition, from: nil, to: false
    remove_column :planets, :hangar_start_time
    add_column :planets, :hangar_start_time, :integer, default: 0
  end
end
