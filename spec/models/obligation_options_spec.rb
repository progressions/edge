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

require 'spec_helper'

describe ObligationOptions do
  pending "add some examples to (or delete) #{__FILE__}"
end
