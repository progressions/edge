# == Schema Information
#
# Table name: social_classes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  key         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :social_class do
    name "MyString"
    description "MyText"
    slug "MyString"
  end
end
