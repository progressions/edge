class AddCreditsToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :credits, :integer
  end
end
