class AddParentIdToRank < ActiveRecord::Migration
  def change
    add_column :ranks, :parent_id, :integer
  end
end
