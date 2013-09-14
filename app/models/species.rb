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
  has_many :species_joins

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

  def specialization_skills_count
    2
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
end
