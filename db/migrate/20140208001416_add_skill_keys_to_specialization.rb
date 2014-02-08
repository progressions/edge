class AddSkillKeysToSpecialization < ActiveRecord::Migration
  def change
    add_column :specializations, :skill_keys, :string
  end
end
