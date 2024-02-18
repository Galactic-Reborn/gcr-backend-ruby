class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :address , null: false , default: ""
      t.timestamps
    end
  end
end
