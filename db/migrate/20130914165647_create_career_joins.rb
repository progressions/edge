class CreateCareerJoins < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.belongs_to :career_join
    end

    create_table :career_joins do |t|
      t.integer :career_id
      t.string :career_skills

      t.timestamps
    end
  end
end
