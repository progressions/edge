class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :name
      t.string :key
      t.text :description

      t.timestamps
    end
  end
end
