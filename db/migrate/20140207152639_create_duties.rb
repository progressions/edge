class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
      t.string :key
      t.string :name
      t.text :description
      t.string :source

      t.timestamps
    end
  end
end
