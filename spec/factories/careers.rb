# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  key           :string(255)
#  name          :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  source        :string(255)
#  career_skills :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :career do
    key "MyString"
    name "MyString"
    description "MyText"
  end
end
