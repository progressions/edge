# == Schema Information
#
# Table name: backgrounds
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  source      :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :background do
    name "MyString"
    slug "MyString"
    description "MyText"
  end
end
