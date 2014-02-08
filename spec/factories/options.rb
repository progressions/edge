# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option do
    option_choice_id 1
    key "MyString"
    name "MyString"
    description "MyString"
    starting_skill_training false
    skill_count 1
    non_career false
  end
end
