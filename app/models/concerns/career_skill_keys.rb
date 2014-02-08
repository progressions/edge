module CareerSkillKeys
  extend ActiveSupport::Concern

  included do
    serialize :skill_keys, Array
  end

  def career_skills
    Skill.where(key: skill_keys)
  end
end
