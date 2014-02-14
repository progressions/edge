# == Schema Information
#
# Table name: skill_trainings
#
#  id          :integer          not null, primary key
#  option_id   :integer
#  skill_count :integer
#  requirement :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_training do
    skill_count 1
    requirements "MyText"
  end
end
