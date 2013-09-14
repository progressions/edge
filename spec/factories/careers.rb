# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  career_skills :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :career do
    name "Career"
    career_skills ["Astrogation", "Charm"]
  end
end
