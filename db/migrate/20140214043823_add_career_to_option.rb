class AddCareerToOption < ActiveRecord::Migration
  def change
    add_column :options, :career, :boolean
  end
end
