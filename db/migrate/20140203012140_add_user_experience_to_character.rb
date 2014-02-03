class AddUserExperienceToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :used_experience, :integer
  end
end
