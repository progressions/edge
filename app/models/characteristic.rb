# == Schema Information
#
# Table name: characteristics
#
#  id           :integer          not null, primary key
#  key          :string(255)
#  name         :string(255)
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Characteristic < ActiveRecord::Base
  include HasRanks

  belongs_to :character

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
      old_rank * -10
    else
      new_rank * 10
    end
  end

  def amount
    ranks.sum(:amount).to_i
  end

  def can_purchase?
    amount < max_purchasable_rank
  end

  def max_purchasable_rank
    5 - non_purchased_amount.to_i
  end
end
