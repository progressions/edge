# == Schema Information
#
# Table name: obligation_options
#
#  id                                     :integer          not null, primary key
#  character_id                           :integer
#  starting_size                          :integer
#  plus_five_xp                           :boolean
#  plus_ten_xp                            :boolean
#  plus_thousand_credits                  :boolean
#  plus_two_thousand_five_hundred_credits :boolean
#  created_at                             :datetime
#  updated_at                             :datetime
#

class ObligationOptions < ActiveRecord::Base
  belongs_to :character


  def update_obligation_options
    margin = character.total_obligation.to_i - self.starting_size.to_i

    if margin < 5
      self.plus_thousand_credits = false
      self.plus_five_xp = false
    end
    if margin < 10
      self.plus_two_thousand_five_hundred_credits = false
      self.plus_ten_xp = false
    end
  end
end
