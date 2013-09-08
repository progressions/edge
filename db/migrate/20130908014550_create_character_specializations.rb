class CreateCharacterSpecializations < ActiveRecord::Migration
  def change
    create_table :character_specializations do |t|
      t.belongs_to :character, index: true
      t.belongs_to :specialization, index: true

      t.timestamps
    end
  end
end
