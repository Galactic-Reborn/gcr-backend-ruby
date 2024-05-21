class AddUniverseFieldsToPlanet < ActiveRecord::Migration[7.1]
  def change
    add_reference :planets, :universe_field, foreign_key: true, type: :uuid
  end
end
