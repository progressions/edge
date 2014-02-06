class AddDamageAddToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :damage_add, :integer
  end
end
