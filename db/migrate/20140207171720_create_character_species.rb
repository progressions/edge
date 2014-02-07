class CreateCharacterSpecies < ActiveRecord::Migration
  def change
    create_table :character_species do |t|
      t.integer :character_id
      t.integer :species_id

      t.timestamps
    end
  end
end
