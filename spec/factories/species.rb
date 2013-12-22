# == Schema Information
#
# Table name: species
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  brawn                     :integer
#  agility                   :integer
#  intellect                 :integer
#  cunning                   :integer
#  willpower                 :integer
#  presence                  :integer
#  base_xp                   :integer
#  wound_threshold_modifier  :integer
#  strain_threshold_modifier :integer
#  optional_skills_count     :integer
#  starting_skills           :string(255)
#  optional_skills           :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :species do
    name "Species"
    brawn 2
    agility 2
    intellect 2
    cunning 2
    willpower 2
    presence 2
    base_xp 2
    wound_threshold_modifier 10
    strain_threshold_modifier 10
    starting_skills []
    optional_skills []
  end
end
