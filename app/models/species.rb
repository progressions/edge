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
  has_many :characters, through: :character_species

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

  def experience=(value)
    self.starting_xp = value
  end
end
