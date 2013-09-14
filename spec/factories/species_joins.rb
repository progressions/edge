# == Schema Information
#
# Table name: species_joins
#
#  id             :integer          not null, primary key
#  species_id     :integer
#  species_skills :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :species_join do
    species { Species.where(name: "Human").first }
    species_skills []
  end
end
