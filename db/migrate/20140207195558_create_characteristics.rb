class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.string :key
      t.string :name
      t.integer :character_id

      t.timestamps
    end
  end
end
