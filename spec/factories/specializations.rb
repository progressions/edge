# == Schema Information
#
# Table name: specializations
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  universal   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  career_id   :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specialization do
    key "MyString"
    name "MyString"
    description "MyText"
    source "MyString"
    universal false
  end
end
