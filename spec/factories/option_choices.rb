# == Schema Information
#
# Table name: option_choices
#
#  id         :integer          not null, primary key
#  species_id :integer
#  key        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option_choice do
    species_id 1
    key "MyString"
    name "MyString"
  end
end
