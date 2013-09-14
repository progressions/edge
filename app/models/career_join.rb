# == Schema Information
#
# Table name: career_joins
#
#  id            :integer          not null, primary key
#  career_id     :integer
#  career_skills :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class CareerJoin < ActiveRecord::Base
  belongs_to :career
  has_one :character

  serialize :career_skills, Array
end
