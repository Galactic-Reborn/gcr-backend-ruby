class AddBuildingQueueToPlanet < ActiveRecord::Migration[7.1]
  def change
    add_column :planets, :building_queue, :json , default: { queue: []}
  end
end
