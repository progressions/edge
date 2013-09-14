# == Schema Information
#
# Table name: specialization_joins
#
#  id                :integer          not null, primary key
#  character_id      :integer
#  specialization_id :integer
#  career_skills     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specialization_joins do
    character nil
    specialization nil
  end
end
