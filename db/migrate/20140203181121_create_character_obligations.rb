class CreateCharacterObligations < ActiveRecord::Migration
  def change
    create_table :character_obligations do |t|
      t.integer :character_id
      t.integer :obligation_id
      t.integer :size

      t.timestamps
    end
  end
end
