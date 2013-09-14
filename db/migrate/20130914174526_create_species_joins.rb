class CreateSpeciesJoins < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.belongs_to :species_join
    end
    remove_column :characters, :species_id, :integer

    create_table :species_joins do |t|
      t.integer :species_id
      t.string :species_skills

      t.timestamps
    end
  end
end
