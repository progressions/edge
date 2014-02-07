class CreateCharacterSpecializations < ActiveRecord::Migration
  def change
    create_table :character_specializations do |t|
      t.integer :character_id
      t.integer :specialization_id

      t.timestamps
    end
  end
end
