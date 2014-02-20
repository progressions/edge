class CreateCharacterTalentBoxes < ActiveRecord::Migration
  def change
    create_table :character_talent_boxes do |t|
      t.belongs_to :character, index: true
      t.belongs_to :talent_box, index: true

      t.timestamps
    end
  end
end
