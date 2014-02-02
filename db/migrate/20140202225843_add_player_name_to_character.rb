class AddPlayerNameToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :player_name, :string
  end
end
