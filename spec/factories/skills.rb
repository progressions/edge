# == Schema Information
#
# Table name: skills
#
#  id             :integer          not null, primary key
#  character_id   :integer
#  name           :string(255)
#  rank           :integer
#  career         :boolean
#  species        :boolean
#  characteristic :string(255)
#  category       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :skill do
    character
    name "Streetwise"
    characteristic "cunning"
    rank 0
    career false
  end
end
