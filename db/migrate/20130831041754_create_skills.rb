class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :character_id
      t.string :name
      t.integer :rank
      t.boolean :career
      t.boolean :species
      t.string :characteristic
      t.string :category

      t.timestamps
    end
  end
end
