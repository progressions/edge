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
  belongs_to :character
  belongs_to :skill

  has_many :rankables, foreign_key: "parent_id", dependent: :destroy
  has_many :purchased_ranks, through: :rankables, source: :rank, class_name: "PurchasedRank"

  delegate :name, to: :skill
  delegate :skill_type, to: :skill

  def career?
    character.career_skills.include?(skill)
  end

  def purchase_ranks(amount)
    self.purchased_ranks = [PurchasedRank.new(amount: amount)]
  end

  def first_purchased_rank
    first_purchased_rank = self.purchased_ranks.first || self.purchased_ranks.build
  end

  def purchased_amount
    first_purchased_rank.amount.to_i
  end
end
