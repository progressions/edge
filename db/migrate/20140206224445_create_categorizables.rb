class CreateCategorizables < ActiveRecord::Migration
  def change
    create_table :categorizables do |t|
      t.integer :category_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
