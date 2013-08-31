class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :character_id
      t.string :name
      t.integer :rank
      t.boolean :career
      t.string :characteristic

      t.timestamps
    end
  end
end
