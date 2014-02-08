# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_skill do
    character_id 1
    skill_id 1
    source "MyString"
  end
end
