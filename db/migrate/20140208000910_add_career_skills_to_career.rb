class AddCareerSkillsToCareer < ActiveRecord::Migration
  def change
    add_column :careers, :career_skills, :string
  end
end
