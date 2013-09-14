# == Schema Information
#
# Table name: obligations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  amount       :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :obligation do
    amount 20
    name "Bounty"
    description "A death mark's not an easy thing to live with."
  end
end
