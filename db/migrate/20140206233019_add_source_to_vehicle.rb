class AddSourceToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :source, :string
  end
end
