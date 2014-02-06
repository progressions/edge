# == Schema Information
#
# Table name: categorizables
#
#  id          :integer          not null, primary key
#  category_id :integer
#  parent_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :categorizable do
    category_id 1
    parent_id 1
  end
end
