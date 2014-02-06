class AddSourceToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :source, :string
  end
end
