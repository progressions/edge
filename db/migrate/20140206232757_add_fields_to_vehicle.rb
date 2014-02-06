class AddFieldsToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :navicomputer, :boolean
    add_column :vehicles, :sensor_range, :string
    add_column :vehicles, :crew, :string
    add_column :vehicles, :encumbrance_capacity, :integer
    add_column :vehicles, :passengers, :integer
    add_column :vehicles, :consummables, :string
    add_column :vehicles, :silhouette, :integer
    add_column :vehicles, :speed, :integer
    add_column :vehicles, :handling, :integer
    add_column :vehicles, :def_fore, :integer
    add_column :vehicles, :def_aft, :integer
    add_column :vehicles, :def_port, :integer
    add_column :vehicles, :def_starboard, :integer
    add_column :vehicles, :armor, :integer
    add_column :vehicles, :hull_trauma, :integer
    add_column :vehicles, :system_strain, :integer
    add_column :vehicles, :hp, :integer
    add_column :vehicles, :price, :integer
    add_column :vehicles, :rarity, :integer
  end
end
