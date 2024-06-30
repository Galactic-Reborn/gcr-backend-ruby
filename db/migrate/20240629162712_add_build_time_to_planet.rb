class AddBuildTimeToPlanet < ActiveRecord::Migration[7.1]
  def change
    add_column :planets, :build_time, :integer, default: 0
  end
end
