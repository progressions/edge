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
    @species = species

    species_class = species.to_s.gsub("'","").capitalize.constantize

    species_class.new
  end

  def initialize
  end

  def generate(user)
    user.assign_attributes(attributes)
    user.assign_attributes(unused_xp: unused_xp, used_xp: 0)
    # set wound threshold
    # set strain threshold
    # reset careers, specs, skills, talents?
  end

  # Default
  #
  def attributes
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
end

class Human < Species
  def attributes
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
end

class Twilek < Species
  def name
    "Twi'lek"
  end

  def attributes
    {
      brawn: 7,
      agility: 2,
      intellect: 2,
      cunning: 3,
      willpower: 2,
      presence: 9
    }
  end

  def unused_xp
    100
  end
end

class Bothan < Species
  def attributes
    {
      brawn: 1,
      agility: 2,
      intellect: 2,
      cunning: 3,
      willpower: 2,
      presence: 2
    }
  end
end

class Wookiee < Species
end

class Rodian < Species
end

class Gand < Species
end

class Trandoshan < Species
end

class Droid < Species
end
