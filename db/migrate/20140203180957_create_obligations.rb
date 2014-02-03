class CreateObligations < ActiveRecord::Migration
  def change
    create_table :obligations do |t|
      t.string :key
      t.string :name
      t.text :description
      t.string :source

      t.timestamps
    end
  end
end
