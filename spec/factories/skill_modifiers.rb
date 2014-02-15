# == Schema Information
#
# Table name: skill_modifiers
#
#  id         :integer          not null, primary key
#  species_id :integer
#  key        :string(255)
#  rank_start :integer
#  rank_limit :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_modifier do
    species nil
    key "MyString"
    rank_start 1
    rank_limit 1
  end
end
