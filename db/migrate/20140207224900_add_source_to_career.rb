class AddSourceToCareer < ActiveRecord::Migration
  def change
    add_column :careers, :source, :string
  end
end
