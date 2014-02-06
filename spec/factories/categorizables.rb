# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :categorizable do
    category_id 1
    parent_id 1
  end
end
