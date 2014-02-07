# == Schema Information
#
# Table name: character_duties
#
#  id           :integer          not null, primary key
#  character_id :integer
#  duty_id      :integer
#  size         :integer
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_duty do
    character_id 1
    duty_id 1
    size 1
    notes "MyText"
  end
end
