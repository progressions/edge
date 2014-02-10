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

  def after_purchased_rank(old_amount, new_amount)
    old_rank = total_amount
    new_rank = non_purchased_amount + new_amount

    xp_cost = cost_of_next_rank(old_rank, new_rank)

    purchase_experience(xp_cost)
  end

  def purchase_experience(cost)
    self.character.experience.purchase(cost)
  end

  def cost_of_next_rank(old_rank, new_rank)
    return 0 if old_rank.to_i == new_rank.to_i

    if old_rank > new_rank
      result = old_rank * -5
      result -= 5 unless career?
    else
      result = new_rank * 5
      result += 5 unless career?
    end

    result
  end

  def career?
    character.career_skills.include?(skill)
  end
end
