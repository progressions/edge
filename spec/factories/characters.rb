# == Schema Information
#
# Table name: characters
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :text
#  user_id                 :integer
#  created_at              :datetime
#  updated_at              :datetime
#  player_name             :string(255)
#  gender                  :string(255)
#  age                     :string(255)
#  height                  :string(255)
#  build                   :string(255)
#  hair                    :string(255)
#  eyes                    :string(255)
#  notable_features        :text
#  credits                 :integer
#  used_experience         :integer
#  portrait_file_name      :string(255)
#  portrait_content_type   :string(255)
#  portrait_file_size      :integer
#  portrait_updated_at     :datetime
#  story                   :text
#  social_class_id         :integer
#  background_id           :integer
#  first_specialization_id :integer
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

    factory :character_with_specialization do
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
end
