# == Schema Information
#
# Table name: skills
#
#  id             :integer          not null, primary key
#  character_id   :integer
#  name           :string(255)
#  rank           :integer
#  career         :boolean
#  species        :boolean
#  characteristic :string(255)
#  category       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Skill < ActiveRecord::Base
  belongs_to :character

  def self.reset_all
    update_all(rank: 0)
  end

  def self.ranked
    where("rank > 0")
  end

  def self.general
    where(category: "general")
  end

  def self.combat
    where(category: "combat")
  end

  def self.knowledge
    where(category: "knowledge")
  end

  def ch
    characteristic.to_s.capitalize[0,2]
  end

  def career_yn?
    career? ? "yes" : "no"
  end

  def career?
    return false unless character.present?

    career_skills = Array(character.career.try(:career_skills)) +
      character.specializations.pluck(:career_skills).flatten

    career_skills.include?(self.name)
  end
end
