# == Schema Information
#
# Table name: character_skills
#
#  id           :integer          not null, primary key
#  character_id :integer
#  skill_id     :integer
#  career       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterSkill < ActiveRecord::Base
  include HasRanks

  belongs_to :character
  belongs_to :skill

  delegate :name, to: :skill
  delegate :skill_type, to: :skill
end
