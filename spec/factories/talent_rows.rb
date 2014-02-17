# == Schema Information
#
# Table name: talent_rows
#
#  id                :integer          not null, primary key
#  specialization_id :integer
#  cost              :integer
#  created_at        :datetime
#  updated_at        :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talent_row do
    specialization nil
    cost 1
  end
end
