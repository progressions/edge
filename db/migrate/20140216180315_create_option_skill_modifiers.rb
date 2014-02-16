class CreateOptionSkillModifiers < ActiveRecord::Migration
  def change
    create_table :option_skill_modifiers do |t|
      t.belongs_to :option, index: true
      t.string :key
      t.integer :rank_start
      t.integer :rank_limit

      t.timestamps
    end
  end
end
