# == Schema Information
#
# Table name: species
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  brawn                     :integer
#  agility                   :integer
#  intellect                 :integer
#  cunning                   :integer
#  willpower                 :integer
#  presence                  :integer
#  unused_xp                 :integer
#  wound_threshold_modifier  :integer
#  strain_threshold_modifier :integer
#  optional_skills_count     :integer
#  starting_skills           :string(255)
#  optional_skills           :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#

class Species < ActiveRecord::Base
  has_many :characters
  serialize :starting_skills, Array
  serialize :optional_skills, Array

  def self.seed!
    SPECIES.values.each do |attributes|
      species = Species.where(name: attributes["name"]).first || Species.create(attributes)
    end
  end

  def career_skills_count
    4
  end

  def characteristics
    {
      brawn: brawn,
      agility: agility,
      intellect: intellect,
      cunning: cunning,
      willpower: willpower,
      presence: presence
    }
  end

  def wound_threshold
    wound_threshold_modifier + brawn
  end

  def strain_threshold
    strain_threshold_modifier + willpower
  end

=begin
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

    reset_skills
    set_starting_skills

    # reset careers, specs, skills, talents?
  end

  def reset_skills
    character.skills.each do |skill|
      skill.rank = 0 unless skill.rank_changed? || skill.species.present?
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
=end
end
