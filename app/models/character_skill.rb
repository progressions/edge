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

  def career?
    character.career_skills.include?(skill)
  end

  def set_career_ranks(amount)
    self.career_ranks = [CareerRank.new(amount: amount)]
  end

  def first_career_rank
    first_career_rank = self.career_ranks.first
  end

  def career_amount
    first_career_rank.amount.to_i
  end

  def set_purchased_ranks(amount)
    if self.purchased_ranks.any?
      self.purchased_ranks.first.update_attributes(amount: amount)
    else
      self.purchased_ranks = [PurchasedRank.new(amount: amount)]
    end
  end

  def first_purchased_rank
    first_purchased_rank = self.purchased_ranks.first
  end

  def purchased_amount
    first_purchased_rank.try(:amount).to_i
  end
end
