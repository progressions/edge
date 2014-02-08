module SkillsHelper
  def career?(skill, character)
    character.career_skills.include?(skill)
  end
end
