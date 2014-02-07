class CreateCharacterCareers < ActiveRecord::Migration
  def change
    create_table :character_careers do |t|
      t.integer :character_id
      t.integer :career_id

      t.timestamps
    end
  end
end
