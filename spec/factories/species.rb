# == Schema Information
#
# Table name: species
#
#  id               :integer          not null, primary key
#  key              :string(255)
#  name             :string(255)
#  description      :text
#  brawn            :integer
#  agility          :integer
#  intellect        :integer
#  cunning          :integer
#  willpower        :integer
#  presence         :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#  starting_xp      :integer
#  created_at       :datetime
#  updated_at       :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :species do
    key "MyString"
    name "MyString"
    description "MyText"
    brawn 1
    agility 1
    intellect 1
    cunning 1
    willpower 1
    presence 1
    wound_threshold 1
    strain_threshold 1
    starting_xp 1
  end
end
