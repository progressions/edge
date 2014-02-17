class CreateTalentBoxes < ActiveRecord::Migration
  def change
    create_table :talent_boxes do |t|
      t.belongs_to :talent_row, index: true
      t.string :key
      t.integer :position
      t.boolean :left
      t.boolean :right
      t.boolean :up
      t.boolean :down

      t.timestamps
    end
  end
end
