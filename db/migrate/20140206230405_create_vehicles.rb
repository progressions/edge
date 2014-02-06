class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :key
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
