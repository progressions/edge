# == Schema Information
#
# Table name: character_obligations
#
#  id            :integer          not null, primary key
#  character_id  :integer
#  obligation_id :integer
#  size          :integer
#  created_at    :datetime
#  updated_at    :datetime
#  notes         :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_obligation do
    character_id 1
    obligation_id 1
    size 1
  end
end
