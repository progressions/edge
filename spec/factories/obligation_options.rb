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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :obligation_option, :class => 'ObligationOptions' do
    character_id 1
    starting_size 1
    plus_five_xp false
    plus_ten_xp false
    plus_thousand_credits false
    plus_two_thousand_five_hundred_credits false
  end
end
