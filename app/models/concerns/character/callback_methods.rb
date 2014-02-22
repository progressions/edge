module Character::CallbackMethods
  extend ActiveSupport::Concern

  def default_experience
    unless self.experience.present?
      self.build_experience
    end
  end

  def default_talents
    Talent.all.each do |talent|
      unless self.talents.include?(talent)
        self.talents << talent
      end
    end
  end

  def default_skills
    Skill.all.each do |skill|
      unless self.skills.include?(skill)
        self.skills << skill
      end
    end
  end

  def default_obligation_options
    self.obligation_options ||= self.create_obligation_options
  end

  def default_credits
    self.credits ||= 500
  end

  def update_first_specialization
    unless self.career.specializations.include?(self.first_specialization)
      self.first_specialization_id = self.career.specializations.first.id
    end

    if changed_attributes.include?(:first_specialization_id)

      # must delete all ranks belonging to career_skills_by_first_spec

      ids = self.career_skills_by_first_specialization.map(&:id).flatten

      spec_ranks = self.character_skills.where(skill_id: ids).map(&:specialization_ranks).flatten
      spec_ranks.map(&:delete)

      self.career_skills_by_first_specialization.delete_all

      self.first_specialization.career_skills.each do |skill|
        self.career_skills_by_first_specialization << skill
      end
    end
  end

  def update_species
  end

  def default_species
    self.species ||= Species.where(name: "Human").first
  end

  def default_career
    self.career ||= Career.where(name: "Smuggler").first
  end

  def default_specialization
    self.first_specialization_id ||= self.career.specializations.first.id
  end
end
