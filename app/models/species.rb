class Species
  attr_accessor :character

  def self.all_species
    [
      "Bothan",
      "Droid",
      "Gand",
      "Human",
      "Rodian",
      "Trandoshan",
      "Twi'lek",
      "Wookiee"
    ]
  end

  def self.all(character=nil)
    all_species.map do |species|
      Species.get(species, character)
    end
  end

  def self.get(species, character=nil)
    if species
      klass = species.to_s.gsub("'", "").capitalize.constantize
      klass.new(character)
    end
  end

  def initialize(character=nil)
    @character = character
  end

  def generate
    character.assign_attributes(characteristics)

    character.assign_attributes(unused_xp: unused_xp, used_xp: 0)
    character.assign_attributes(wound_threshold: wound_threshold)
    character.assign_attributes(strain_threshold: strain_threshold)

    Rails.logger.info("############################################")
    Rails.logger.info("About to reset skills")
    reset_skills
    Rails.logger.info("Just reset skills")
    Rails.logger.info("############################################")
    set_starting_skills

    # reset careers, specs, skills, talents?
  end

  def reset_skills
    character.skills.each do |skill|
      skill.rank = 0 unless skill.rank_changed? || skill.species?
    end
  end

  def set_starting_skills
    starting_skills.each do |skill|
      character.add_rank_to_skill(skill[:name], skill[:rank])
    end
  end

  def starting_skills
    []
  end

  # Default
  #
  def characteristics
    {
      brawn: 2,
      agility: 2,
      intellect: 2,
      cunning: 2,
      willpower: 2,
      presence: 2
    }
  end

  def unused_xp
    100
  end

  def name
    self.class.to_s
  end

  def identifier
    name.downcase.gsub("'", "")
  end

  def set_skills
  end

  def wound_threshold_modifier
    10
  end

  def strain_threshold_modifier
    10
  end

  def wound_threshold
    characteristics[:brawn] + wound_threshold_modifier
  end

  def strain_threshold
    characteristics[:willpower] + strain_threshold_modifier
  end

  def optional_skills?
    [optional_skills].flatten.any?
  end

  def optional_skills
    []
  end

  def optional_skills_count
    0
  end

  def optional_skills_unique
    true
  end
end
