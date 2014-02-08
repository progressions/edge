class CreateCharacterSkills < ActiveRecord::Migration
  def change
    create_table :character_skills do |t|
      t.integer :character_id
      t.integer :skill_id
      t.string :source

      t.timestamps
    end
  end
end
