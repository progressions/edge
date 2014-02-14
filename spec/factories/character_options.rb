# == Schema Information
#
# Table name: character_options
#
#  id                   :integer          not null, primary key
#  character_species_id :integer
#  choice_key           :string(255)
#  option_key           :string(255)
#  skill_trainings      :text
#  created_at           :datetime
#  updated_at           :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character_option do
    character_species nil
    choice_key "MyString"
    option_key "MyString"
  end
end
