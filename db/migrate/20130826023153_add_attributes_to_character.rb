class AddAttributesToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :brawn, :integer, null: false, default: 0
    add_column :characters, :agility, :integer, null: false, default: 0
    add_column :characters, :intellect, :integer, null: false, default: 0
    add_column :characters, :cunning, :integer, null: false, default: 0
    add_column :characters, :willpower, :integer, null: false, default: 0
    add_column :characters, :presence, :integer, null: false, default: 0
  end
end
