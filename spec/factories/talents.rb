# == Schema Information
#
# Table name: talents
#
#  id                   :integer          not null, primary key
#  key                  :string(255)
#  name                 :string(255)
#  description          :string(255)
#  ranked               :boolean
#  activation           :string(255)
#  additional_hp        :integer
#  source               :string(255)
#  talent_attributes    :text
#  damage               :text
#  choose_career_skills :text
#  jury_rigged          :boolean
#  skill_choice         :text
#  created_at           :datetime
#  updated_at           :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talent do
    key "MyString"
    name "MyString"
    description "MyString"
    ranked false
    activation "MyString"
    additional_hp 1
    source "MyString"
    attributes "MyText"
    damage "MyText"
    choose_career_skills "MyText"
    jury_rigged false
    skill_choice "MyText"
  end
end
