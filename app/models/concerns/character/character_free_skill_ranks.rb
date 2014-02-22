module CharacterFreeSkillRanks
  extend ActiveSupport::Concern

  def char_skills_by_species
    ids = self.career_skills_by_species.pluck(:id)
    self.character_skills.where(skill_id: ids)
  end

  def char_skills_by_career
    ids = self.career_skills_by_career.pluck(:id)
    self.character_skills.where(skill_id: ids)
  end

  def char_skills_by_specialization
    ids = self.career_skills_by_first_specialization.pluck(:id)
    self.character_skills.where(skill_id: ids)
  end

  def free_species_skill_ranks
    character_skills.select do |cs|
      cs.species_amount > 0
    end
  end

  def free_career_skill_ranks
    char_skills_by_career.map(&:career_ranks).flatten.select do |rank|
      rank.amount.to_i > 0
    end
  end

  def free_specialization_skill_ranks
    char_skills_by_specialization.map(&:specialization_ranks).flatten.select do |rank|
      rank.amount.to_i > 0
    end
  end

  def free_species_skill_ranks_remaining
    total_free_species_skill_ranks - free_species_skill_ranks.try(:count).to_i
  end

  def free_career_skill_ranks_remaining
    total_free_career_skill_ranks - free_career_skill_ranks.try(:count).to_i
  end

  def free_specialization_skill_ranks_remaining
    total_free_specialization_skill_ranks - free_specialization_skill_ranks.try(:count).to_i
  end

  def total_free_species_skill_ranks
    2
  end

  def total_free_career_skill_ranks
    4 + self.species.career_skill_bonus.to_i
  end

  def total_free_specialization_skill_ranks
    2 + self.species.specialization_skill_bonus.to_i
  end

  def more_free_species_skill_ranks?
    free_species_skill_ranks_remaining > 0
  end

  def more_free_career_skill_ranks?
    free_career_skill_ranks_remaining > 0
  end

  def more_free_specialization_skill_ranks?
    free_specialization_skill_ranks_remaining > 0
  end

end
