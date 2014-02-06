# == Schema Information
#
# Table name: vehicles
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    key "MyString"
    name "MyString"
    description "MyText"
  end
end
