# == Schema Information
#
# Table name: specializations
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  career_skills :string(255)
#  career_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Specialization < ActiveRecord::Base
  belongs_to :career
  has_many :character_specializations
  has_many :characters, through: :character_specializations

  serialize :career_skills, Array

  def full_name
    "#{career.name} - #{name}"
  end
end
