class RemoveCareerIdFromCharacter < ActiveRecord::Migration
  def change
    remove_column :characters, :career_id, :integer
  end
end
