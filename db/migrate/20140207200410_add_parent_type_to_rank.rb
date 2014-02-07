class AddParentTypeToRank < ActiveRecord::Migration
  def change
    add_column :ranks, :parent_type, :string
  end
end
