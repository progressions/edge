# == Schema Information
#
# Table name: experiences
#
#  id           :integer          not null, primary key
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :experience do
    character nil
  end
end
