class AddXpToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :unused_xp, :integer, null: false, default: 0
    add_column :characters, :used_xp, :integer, null: false, default: 0
  end
end
