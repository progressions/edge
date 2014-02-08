class AddSkillKeysToCareer < ActiveRecord::Migration
  def change
    add_column :careers, :skill_keys, :string
  end
end
