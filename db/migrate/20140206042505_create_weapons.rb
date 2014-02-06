class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :key
      t.text :description
      t.string :skill_key
      t.integer :damage
      t.integer :crit
      t.string :range
      t.integer :encumbrance
      t.integer :hp
      t.integer :price
      t.integer :rarity

      t.timestamps
    end
  end
end
