# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  value      :integer
#  source     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rank do
    value 1
    source "MyString"
  end
end
