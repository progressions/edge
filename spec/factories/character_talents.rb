# == Schema Information
#
# Table name: character_talents
#
#  id           :integer          not null, primary key
#  character_id :integer
#  talent_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_talent do
    character nil
    talent nil
  end
end
