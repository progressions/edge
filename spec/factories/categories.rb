# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name "MyString"
    categorizable_id 1
    categorizable_type "MyString"
  end
end
