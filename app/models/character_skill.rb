# == Schema Information
#
# Table name: character_skills
#
#  id           :integer          not null, primary key
#  character_id :integer
#  skill_id     :integer
#  career       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterSkill < ActiveRecord::Base
  include HasRanks

  belongs_to :character
  belongs_to :skill

  delegate :name, to: :skill
  delegate :skill_type, to: :skill
  delegate :key, to: :skill

  def experience_cost
    cost = 0
    purchased_amount.times do |i|
      cost += (total_amount - i) * 5
      cost += 5 unless career?
    end
    cost
  end

  def career?
    character.career_skills.include?(skill)
  end
end
