# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  amount     :integer
#  source     :string(255)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rank do
    amount 1
    type ""
  end
end
