class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :key
      t.string :name
      t.text :description
      t.integer :brawn
      t.integer :agility
      t.integer :intellect
      t.integer :cunning
      t.integer :willpower
      t.integer :presence
      t.integer :wound_threshold
      t.integer :strain_threshold
      t.integer :starting_xp

      t.timestamps
    end
  end
end
