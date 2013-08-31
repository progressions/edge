class AddPartySizeToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :party_size, :integer
    add_column :characters, :base_obligation, :integer
  end
end
