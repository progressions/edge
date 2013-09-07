FactoryGirl.define do
  factory :character do
    user
    name { Faker::Name.name }
    species

    brawn 2
    agility 3
    intellect 3
    cunning 2
    willpower 4
    presence 2

    unused_xp 100
    used_xp 0

    party_size 6
    base_obligation 5

    wound_threshold 12
    strain_threshold 14
  end
end
