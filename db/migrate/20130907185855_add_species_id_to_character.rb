class AddSpeciesIdToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :species_id, :integer
  end
end
