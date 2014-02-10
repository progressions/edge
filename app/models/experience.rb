# == Schema Information
#
# Table name: experiences
#
#  id           :integer          not null, primary key
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Experience < ActiveRecord::Base
  belongs_to :character

  def spent_experience
    total_skill_cost + total_characteristics_cost
  end

  def total_skill_cost
    self.character.character_skills.map(&:experience_cost).sum
  end

  def total_characteristics_cost
    self.character.characteristics.map(&:experience_cost).sum
  end

  def purchase(amount)
    difference = self.purchased_amount - amount.to_i
    self.set_purchased_ranks(difference)
  end
end
