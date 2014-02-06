# == Schema Information
#
# Table name: categorizables
#
#  id                 :integer          not null, primary key
#  category_id        :integer
#  categorizable_type :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :categorizable do
    category_id 1
    categorizable_type "MyString"
  end
end
