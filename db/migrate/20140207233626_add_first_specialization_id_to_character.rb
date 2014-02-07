class AddFirstSpecializationIdToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :first_specialization_id, :integer
  end
end
