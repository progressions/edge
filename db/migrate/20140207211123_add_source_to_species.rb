class AddSourceToSpecies < ActiveRecord::Migration
  def change
    add_column :species, :source, :string
  end
end
