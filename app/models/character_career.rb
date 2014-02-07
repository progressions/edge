# == Schema Information
#
# Table name: character_careers
#
#  id           :integer          not null, primary key
#  character_id :integer
#  career_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterCareer < ActiveRecord::Base
end
