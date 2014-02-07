# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  char_key    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    key "MyString"
    name "MyString"
    description "MyText"
    source "MyString"
    char_key "MyString"
  end
end
