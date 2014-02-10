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
  include HasRanks

  belongs_to :character

  def purchase(amount)
    difference = self.purchased_amount - amount.to_i
    self.set_purchased_ranks(difference)
  end
end
