# == Schema Information
#
# Table name: rankables
#
#  id         :integer          not null, primary key
#  rank_id    :integer
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rankable do
    rank_id 1
    parent_id 1
  end
end
