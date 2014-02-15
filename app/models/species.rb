# == Schema Information
#
# Table name: species
#
#  id               :integer          not null, primary key
#  key              :string(255)
#  name             :string(255)
#  description      :text
#  brawn            :integer
#  agility          :integer
#  intellect        :integer
#  cunning          :integer
#  willpower        :integer
#  presence         :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#  starting_xp      :integer
#  created_at       :datetime
#  updated_at       :datetime
#  source           :string(255)
#

class Species < ActiveRecord::Base
  include Sourced

  has_many :skill_modifiers

  has_many :option_choices

  has_many :characters, through: :character_species

  def career_skills
    []
  end

  def self.official
    where(source: [nil, "Enter the Unknown", "Suns of Fortune", "Age of Rebellion Rulebook"])
  end

  def starting_chars=(values)
    attributes_from_xml(values)
  end

  def starting_attrs=(values)
    attributes_from_xml(values)
  end

  def attributes_from_xml(values)
    values.map do |k,v|
      if self.respond_to?("#{k.underscore}=".to_sym)
        self.update_attribute(k.underscore, v)
      end
    end
  end

  def option_choices_from_xml=(values)
    values = [values].flatten
    values.each do |choice_values|
      choice_values[:species_id] = self.id
      Loader.load_single(OptionChoice, choice_values)
    end
  end

  def experience=(value)
    self.starting_xp = value
  end
end
