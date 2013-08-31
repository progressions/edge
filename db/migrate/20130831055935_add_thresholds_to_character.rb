class AddThresholdsToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :wound_threshold, :integer
    add_column :characters, :strain_threshold, :integer
  end
end
