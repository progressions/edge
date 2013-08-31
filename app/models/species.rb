class Species
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

  def self.all
    all_species.map do |species|
      Species.get(species)
    end
  end

  def self.get(species)
    species.to_s.gsub("'", "").capitalize.constantize.new
  end

  def initialize
  end

  def generate(character)
    character.assign_attributes(characteristics)
    character.assign_attributes(unused_xp: unused_xp, used_xp: 0)
    character.assign_attributes(wound_threshold: wound_threshold)
    character.assign_attributes(strain_threshold: strain_threshold)
    # reset careers, specs, skills, talents?
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

  def reset_skills
    character.skills.destroy_all
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
end
