# == Schema Information
#
# Table name: options
#
#  id                      :integer          not null, primary key
#  option_choice_id        :integer
#  key                     :string(255)
#  name                    :string(255)
#  description             :string(255)
#  starting_skill_training :boolean
#  skill_count             :integer
#  non_career              :boolean
#  created_at              :datetime
#  updated_at              :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option do
    option_choice_id 1
    key "MyString"
    name "MyString"
    description "MyString"
    starting_skill_training false
    skill_count 1
    non_career false
  end
end
