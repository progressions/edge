class AddSkillKeysToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :skill_keys, :string
  end
end
