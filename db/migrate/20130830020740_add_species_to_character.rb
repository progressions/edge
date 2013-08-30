class AddSpeciesToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :species, :string
  end
end
