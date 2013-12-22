# == Schema Information
#
# Table name: points
#
#  id         :integer          not null, primary key
#  skill_id   :integer
#  source     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    belongs_to ""
    source "MyString"
  end
end
