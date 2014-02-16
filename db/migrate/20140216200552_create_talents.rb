class CreateTalents < ActiveRecord::Migration
  def change
    create_table :talents do |t|
      t.string :key
      t.string :name
      t.string :description
      t.boolean :ranked
      t.string :activation
      t.integer :additional_hp
      t.string :source
      t.text :talent_attributes
      t.text :damage
      t.text :choose_career_skills
      t.boolean :jury_rigged
      t.text :skill_choice

      t.timestamps
    end
  end
end
