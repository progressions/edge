class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :name
      t.string :career_skills
      t.integer :career_id

      t.timestamps
    end
  end
end
