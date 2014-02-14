# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :add do
    character_option "MyString"
    choice_key "MyString"
    option_key "MyString"
    references ""
  end
end
