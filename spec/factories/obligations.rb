# == Schema Information
#
# Table name: obligations
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :obligation do
    key "MyString"
    name "MyString"
    description "MyText"
    source "MyString"
  end
end
