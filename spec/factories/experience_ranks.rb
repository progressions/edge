# == Schema Information
#
# Table name: experience_ranks
#
#  id           :integer          not null, primary key
#  character_id :integer
#  amount       :integer
#  source       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :experience_rank, :class => 'ExperienceRanks' do
    character_id 1
    amount 1
    source "MyString"
  end
end
