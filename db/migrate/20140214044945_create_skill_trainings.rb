class CreateSkillTrainings < ActiveRecord::Migration
  def change
    create_table :skill_trainings do |t|
      t.belongs_to :option
      t.integer :skill_count
      t.text :requirements

      t.timestamps
    end
  end
end
