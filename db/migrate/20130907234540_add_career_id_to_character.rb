class AddCareerIdToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :career_id, :integer
  end
end
