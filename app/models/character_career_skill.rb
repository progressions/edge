# == Schema Information
#
# Table name: character_career_skills
#
#  id           :integer          not null, primary key
#  character_id :integer
#  skill_id     :integer
#  source       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterCareerSkill < ActiveRecord::Base
  belongs_to :character
  belongs_to :skill
end
