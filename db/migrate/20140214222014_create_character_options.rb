class CreateCharacterOptions < ActiveRecord::Migration
  def change
    create_table :character_options do |t|
      t.belongs_to :character, index: true
      t.string :choice_key
      t.string :option_key
      t.text :starting_skills

      t.timestamps
    end
  end
end
