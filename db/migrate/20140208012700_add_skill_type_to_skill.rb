class AddSkillTypeToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :skill_type, :string
  end
end
