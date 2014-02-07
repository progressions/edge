class AddCareerIdToSpecialization < ActiveRecord::Migration
  def change
    add_column :specializations, :career_id, :integer
  end
end
