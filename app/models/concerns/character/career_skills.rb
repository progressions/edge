module Character::CareerSkills
  extend ActiveSupport::Concern

  def career_skill_ids
    career_skills.pluck(:id)
  end

  def career_skills_by_specialization_ids=(values)
    set_career_skill_ids(:specialization, values)
  end

  def career_skill_by_career_ids=(values)
    set_career_skill_ids(:career, values)
  end

  def career_skill_by_species_ids=(values)
    set_career_skill_ids(:species, values)
  end

  def set_career_skill_ids(source, values)
    values.each do |skill_id, value|
      skill = Skill.find(skill_id)
      if value.last == "true"
        self.send("career_skills_by_#{source}") << skill
      else
        self.send("career_skills_by_#{source}").delete(skill)
      end
    end
  end

  def free_ranks(key, values)
    values.each do |skill_id, value|
      if value.last == "true"
        amount = 1
      else
        amount = 0
      end
      character_skill = self.character_skills.where(skill_id: skill_id).first
      character_skill.send("set_#{key}_ranks", amount)
    end
  end

  def species_skill_ranks=(values)
    free_ranks(:species, values)
  end

  def career_skill_ranks=(values)
    free_ranks(:career, values)
  end

  def specialization_skill_ranks=(values)
    free_ranks(:specialization, values)
  end
end
