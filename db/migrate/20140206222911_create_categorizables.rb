class CreateCategorizables < ActiveRecord::Migration
  def change
    create_table :categorizables do |t|
      t.integer :category_id
      t.string :categorizable_type

      t.timestamps
    end
  end
end
