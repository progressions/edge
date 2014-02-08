# == Schema Information
#
# Table name: career_skills
#
#  id           :integer          not null, primary key
#  character_id :integer
#  skill_id     :integer
#  source       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class CareerSkill < ActiveRecord::Base
end
