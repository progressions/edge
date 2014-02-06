# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weapon do
    name "MyString"
    key "MyString"
    description "MyText"
    skill_key "MyString"
    damage 1
    crit 1
    range "MyString"
    encumbrance 1
    hp 1
    price 1
    rarity 1
    weapon_type "MyString"
  end
end
