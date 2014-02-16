# == Schema Information
#
# Table name: talents
#
#  id                   :integer          not null, primary key
#  key                  :string(255)
#  name                 :string(255)
#  description          :string(255)
#  ranked               :boolean
#  activation           :string(255)
#  additional_hp        :integer
#  source               :string(255)
#  attributes           :text
#  damage               :text
#  choose_career_skills :text
#  jury_rigged          :boolean
#  skill_choice         :text
#  created_at           :datetime
#  updated_at           :datetime
#

class Talent < ActiveRecord::Base
  belongs_to :character_talent
  has_many :characters, through: :character_talent
end
