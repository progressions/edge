class CreateSkillModifiers < ActiveRecord::Migration
  def change
    create_table :skill_modifiers do |t|
      t.belongs_to :species, index: true
      t.string :key
      t.integer :rank_start
      t.integer :rank_limit

      t.timestamps
    end
  end
end
