# == Schema Information
#
# Table name: skill_modifiers
#
#  id         :integer          not null, primary key
#  species_id :integer
#  key        :string(255)
#  rank_start :integer
#  rank_limit :integer
#  created_at :datetime
#  updated_at :datetime
#

class SkillModifier < ActiveRecord::Base
  belongs_to :species

  def self.unique_key?
    false
  end

  def skill
    Skill.where(key: key).first
  end
end
