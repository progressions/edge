# == Schema Information
#
# Table name: characters
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  brawn            :integer          default(0), not null
#  agility          :integer          default(0), not null
#  intellect        :integer          default(0), not null
#  cunning          :integer          default(0), not null
#  willpower        :integer          default(0), not null
#  presence         :integer          default(0), not null
#  unused_xp        :integer          default(0), not null
#  used_xp          :integer          default(0), not null
#  party_size       :integer
#  base_obligation  :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#  career_join_id   :integer
#  species_join_id  :integer
#

FactoryGirl.define do
  factory :character do
    user
    name { Faker::Name.name }
    species_join
    career_join

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
