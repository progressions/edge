# == Schema Information
#
# Table name: skills
#
#  id             :integer          not null, primary key
#  character_id   :integer
#  name           :string(255)
#  rank           :integer
#  career         :boolean
#  characteristic :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Skill < ActiveRecord::Base
  belongs_to :character
end
