class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :name
      t.integer :brawn
      t.integer :agility
      t.integer :intellect
      t.integer :cunning
      t.integer :willpower
      t.integer :presence
      t.integer :unused_xp
      t.integer :wound_threshold_modifier
      t.integer :strain_threshold_modifier
      t.integer :optional_skills_count
      t.string :starting_skills
      t.string :optional_skills

      t.timestamps
    end
  end
end
