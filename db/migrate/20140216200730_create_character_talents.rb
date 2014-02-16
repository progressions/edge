class CreateCharacterTalents < ActiveRecord::Migration
  def change
    create_table :character_talents do |t|
      t.belongs_to :character, index: true
      t.belongs_to :talent, index: true

      t.timestamps
    end
  end
end
