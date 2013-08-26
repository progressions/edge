class CreateObligations < ActiveRecord::Migration
  def change
    create_table :obligations do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.integer :character_id

      t.timestamps
    end
  end
end
