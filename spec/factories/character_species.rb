# == Schema Information
#
# Table name: character_species
#
#  id              :integer          not null, primary key
#  character_id    :integer
#  species_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  choice_key      :string(255)
#  option_key      :string(255)
#  skill_trainings :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_specy, :class => 'CharacterSpecies' do
    character_id 1
    species_id 1
  end
end
