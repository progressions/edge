# == Schema Information
#
# Table name: weapons
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :text
#  skill_key   :string(255)
#  damage      :integer
#  crit        :integer
#  range       :string(255)
#  encumbrance :integer
#  hp          :integer
#  price       :integer
#  rarity      :integer
#  weapon_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  damage_add  :integer
#  source      :string(255)
#

class Weapon < ActiveRecord::Base
  RANGES = {
    "RANGLT" => "Ranged (Light)",
    "RANGHVY" => "Ranged (Heavy)",
    "GUNN" => "Gunnery",
    "BRAWL" => "Brawl",
    "MELEE" => "Melee",
    "LTSABER" => "Lightsaber"
  }

  def skill
    RANGES[self.skill_key] || self.skill_key
  end

  def display_damage
    if damage > 0
      damage
    else
      "+#{damage_add}"
    end
  end

  def source
    self.read_attribute(:source) || "Edge of the Empire Rulebook"
  end
end
