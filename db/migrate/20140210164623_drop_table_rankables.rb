class DropTableRankables < ActiveRecord::Migration
  def change
    drop_table(:rankables)
  end
end
