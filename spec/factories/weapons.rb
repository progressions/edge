# == Schema Information
#
# Table name: weapons
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :text
#  skill_key   :string(255)
#  damage      :integer
#  crit        :integer
#  range       :string(255)
#  encumbrance :integer
#  hp          :integer
#  price       :integer
#  rarity      :integer
#  weapon_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  damage_add  :integer
#  source      :string(255)
#

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
