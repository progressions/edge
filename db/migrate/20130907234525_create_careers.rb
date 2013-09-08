class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :name
      t.string :career_skills

      t.timestamps
    end
  end
end
