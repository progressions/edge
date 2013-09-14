class CreateSpecializationJoins < ActiveRecord::Migration
  def change
    create_table :specialization_joins do |t|
      t.belongs_to :character, index: true
      t.belongs_to :specialization, index: true
      t.string :career_skills

      t.timestamps
    end
  end
end
