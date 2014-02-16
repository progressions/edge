# == Schema Information
#
# Table name: option_skill_modifiers
#
#  id         :integer          not null, primary key
#  option_id  :integer
#  key        :string(255)
#  rank_start :integer
#  rank_limit :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option_skill_modifier do
    option nil
    key "MyString"
    rank_start 1
    rank_limit 1
  end
end
