class AddBuildLevelToPlanet < ActiveRecord::Migration[7.1]
  def change
    add_column :planets, :build_level, :integer, default: 0
  end
end
