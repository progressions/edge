FactoryGirl.define do
  factory :character do
    user
    name { Faker::Name.name }
    species { Species.where(name: "Human").first }
    career { Career.where(name: "Bounty Hunter").first }

    brawn 2
    agility 2
    intellect 2
    cunning 2
    willpower 2
    presence 2

    unused_xp 100
    used_xp 0

    party_size 6
    base_obligation 5

    wound_threshold 12
    strain_threshold 12

    after :create do |c|
      if c.career.present?
        c.specializations << c.career.specializations.first
      else
        c.career = create(:career)
        c.specializations << create(:specialization)
      end
    end
  end
end
