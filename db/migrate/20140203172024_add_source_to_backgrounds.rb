class AddSourceToBackgrounds < ActiveRecord::Migration
  def change
    add_column :backgrounds, :source, :string
  end
end
