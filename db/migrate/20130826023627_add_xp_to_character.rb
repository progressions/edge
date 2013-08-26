class AddXpToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :unused_xp, :integer
    add_column :characters, :used_xp, :integer
  end
end
