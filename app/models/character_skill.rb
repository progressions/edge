# == Schema Information
#
# Table name: character_skills
#
#  id           :integer          not null, primary key
#  character_id :integer
#  skill_id     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterSkill < ActiveRecord::Base
end
