class ChangePlanetLastUpdated < ActiveRecord::Migration[7.1]
  def change
    remove_column :planets, :last_updated, :datetime
    add_column :planets, :last_updated, :integer, default: 0
  end
end
