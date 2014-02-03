class AddSocialClassAndBackgroundToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :social_class, :string
    add_column :characters, :background, :string
    add_column :characters, :story, :text
  end
end
