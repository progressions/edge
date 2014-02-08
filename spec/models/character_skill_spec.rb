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

require 'spec_helper'

describe CharacterSkill do
  pending "add some examples to (or delete) #{__FILE__}"
end
