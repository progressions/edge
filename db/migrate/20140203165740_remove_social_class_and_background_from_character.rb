class RemoveSocialClassAndBackgroundFromCharacter < ActiveRecord::Migration
  def change
    remove_column :characters, :social_class, :string
    remove_column :characters, :background, :string
  end
end
