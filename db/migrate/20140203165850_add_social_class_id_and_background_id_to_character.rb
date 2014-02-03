class AddSocialClassIdAndBackgroundIdToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :social_class_id, :integer
    add_column :characters, :background_id, :integer
  end
end
