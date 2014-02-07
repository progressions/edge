class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :key
      t.string :name
      t.text :description
      t.string :source
      t.boolean :universal

      t.timestamps
    end
  end
end
