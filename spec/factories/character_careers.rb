# == Schema Information
#
# Table name: character_careers
#
#  id           :integer          not null, primary key
#  character_id :integer
#  career_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_career do
    character_id 1
    career_id 1
  end
end
