class CreateRankables < ActiveRecord::Migration
  def change
    create_table :rankables do |t|
      t.integer :rank_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
