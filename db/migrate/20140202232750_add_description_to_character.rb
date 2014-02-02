class AddDescriptionToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :gender, :string
    add_column :characters, :age, :string
    add_column :characters, :height, :string
    add_column :characters, :build, :string
    add_column :characters, :hair, :string
    add_column :characters, :eyes, :string
    add_column :characters, :notable_features, :text
  end
end
