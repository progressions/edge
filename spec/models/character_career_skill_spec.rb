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

require 'spec_helper'

describe CharacterCareerSkill do
  pending "add some examples to (or delete) #{__FILE__}"
end
