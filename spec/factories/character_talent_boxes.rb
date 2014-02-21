# == Schema Information
#
# Table name: character_talent_boxes
#
#  id            :integer          not null, primary key
#  character_id  :integer
#  talent_box_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_talent_box do
    character nil
    talent_box nil
  end
end
