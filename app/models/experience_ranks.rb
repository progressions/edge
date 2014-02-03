# == Schema Information
#
# Table name: experience_ranks
#
#  id           :integer          not null, primary key
#  character_id :integer
#  amount       :integer
#  source       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class ExperienceRanks < ActiveRecord::Base
  belongs_to :characte
end
