class AddXpToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :available_xp, :integer
    add_column :characters, :spent_xp, :integer
  end
end
