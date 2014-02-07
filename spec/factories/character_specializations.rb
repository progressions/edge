# == Schema Information
#
# Table name: character_specializations
#
#  id                :integer          not null, primary key
#  character_id      :integer
#  specialization_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_specialization do
    character_id 1
    specialization_id 1
  end
end
