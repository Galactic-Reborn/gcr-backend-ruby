class DeleteMinePercentagePlanet < ActiveRecord::Migration[7.1]
  def change
    remove_column :planets, :titanium_mine_percentage, :integer
    remove_column :planets, :auronium_mine_percentage, :integer
    remove_column :planets, :hydrogen_mine_percentage, :integer
  end
end
