class CreateCharacterDuties < ActiveRecord::Migration
  def change
    create_table :character_duties do |t|
      t.integer :character_id
      t.integer :duty_id
      t.integer :size
      t.text :notes

      t.timestamps
    end
  end
end
