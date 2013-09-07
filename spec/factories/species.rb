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
    unused_xp 2
    wound_threshold_modifier 10
    strain_threshold_modifier 10
    starting_skills []
    optional_skills []
  end
end
