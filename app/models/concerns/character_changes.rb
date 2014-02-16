module CharacterChanges
  extend ActiveSupport::Concern

  def on_species_change
    ids = self.character_species.character_options.pluck(:id)
    CharacterOption.where(id: ids).delete_all

    self.species.option_choices.each do |choice|
      choice.options.each do |option|
        self.set_species_option(option.id)
      end
    end

    clear_all_species_ranks
    update_species_skills
    default_characteristics
  end

  def update_species_skills
    self.species.skill_modifiers.each do |sm|
      skill = sm.skill
      char_skill = self.character_skills.where(skill_id: skill.id).first
      char_skill.set_species_ranks(sm.rank_start)
    end

    self.character_options.each do |co|
      co.skill_modifiers.each do |sm|
        skill = sm.skill
        char_skill = self.character_skills.where(skill_id: skill.id).first
        char_skill.set_species_ranks(sm.rank_start)
      end
    end
  end

  def clear_species_skill_ranks
    ranks = self.character_skills.map(&:species_ranks).flatten.map(&:id)
    Rank.where(id: ranks).delete_all
  end

  def clear_all_species_ranks
    ranks = self.character_skills.map(&:species_ranks).flatten.map(&:id)
    ranks += self.characteristics.map(&:species_ranks).flatten.map(&:id)
    Rank.where(id: ranks).delete_all
  end

  def on_career_change
    ranks = self.character_skills.map(&:career_ranks).flatten
    ranks.each(&:destroy)
  end
end
