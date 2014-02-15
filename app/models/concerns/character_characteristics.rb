module CharacterCharacteristics
  extend ActiveSupport::Concern

  included do
    CHARACTERISTICS = [:brawn, :agility, :intellect, :cunning, :willpower, :presence]
  end

  def default_characteristics
    CHARACTERISTICS.each do |ch|
      default_characteristic(ch)
    end
  end

  def default_characteristic(ch)
    char = send(ch) || send("build_#{ch}")
    char.set_species_ranks(species.send(ch))
    char.save
  end

  def update_species_skills
    self.species.skill_modifiers.each do |sm|
      skill = sm.skill
      char_skill = self.character_skills.where(skill_id: skill.id).first
      char_skill.set_species_ranks(sm.rank_start)
    end
  end

  def on_species_change
    ids = self.character_species.character_options.pluck(:id)
    CharacterOption.where(id: ids).delete_all

    self.species.option_choices.each do |choice|
      choice.options.each do |option|
        self.species_option = option.id
      end
    end

    ranks = self.character_skills.map(&:species_ranks).flatten.map(&:id)
    ranks += self.characteristics.map(&:species_ranks).flatten.map(&:id)
    Rank.where(id: ranks).delete_all

    update_species_skills
    default_characteristics
  end

  def on_career_change
    ranks = self.character_skills.map(&:career_ranks).flatten
    ranks.each(&:destroy)
  end

  def characteristic_amounts
    results = {}
    CHARACTERISTICS.each do |ch|
      results[ch] = send(ch).total_amount
    end
    results
  end
end
