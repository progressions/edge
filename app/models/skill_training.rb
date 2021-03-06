# == Schema Information
#
# Table name: skill_trainings
#
#  id          :integer          not null, primary key
#  option_id   :integer
#  skill_count :integer
#  requirement :text
#  created_at  :datetime
#  updated_at  :datetime
#

class SkillTraining < ActiveRecord::Base
  belongs_to :option

  serialize :requirement, Hash

  def career?
    !!requirement["Career"]
  end

  def specialization?
    !!requirement["Specialization"]
  end

  def non_career?
    !!requirement["NonCareer"]
  end
end
