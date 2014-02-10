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
