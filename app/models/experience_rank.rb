# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  amount     :integer
#  source     :string(255)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ExperienceRank < Rank
end
