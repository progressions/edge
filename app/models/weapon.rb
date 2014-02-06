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
  has_many :categorizables, foreign_key: "parent_id", dependent: :destroy
  has_many :categories, through: :categorizables

  RANGES = {
    "RANGLT" => "Ranged (Light)",
    "RANGHVY" => "Ranged (Heavy)",
    "GUNN" => "Gunnery",
    "BRAWL" => "Brawl",
    "MELEE" => "Melee",
    "LTSABER" => "Lightsaber"
  }

  def category_names
    categories.pluck(:name)
  end

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

  def categories_from_xml=(values)
    values = Array(values)
    values.each do |value|
      category = Category.where(name: value).first || Category.new(name: value)
      categories << category
    end
  end
end
