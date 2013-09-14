# == Schema Information
#
# Table name: career_joins
#
#  id            :integer          not null, primary key
#  career_id     :integer
#  career_skills :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :career_join do
    career { Career.where(name: "Bounty Hunter").first }
    career_skills []
  end
end
