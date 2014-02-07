# == Schema Information
#
# Table name: duty_options
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

class DutyOptions < ActiveRecord::Base
end
