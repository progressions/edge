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

  def experience_cost
    cost = 0
    purchased_amount.times do |i|
      cost += (total_amount - i) * 10
    end
    cost
  end

  def can_purchase?
    amount < max_purchasable_rank
  end

  def max_purchasable_rank
    5 - non_purchased_amount.to_i
  end
end
