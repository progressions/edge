# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  value      :integer
#  source     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Rank < ActiveRecord::Base

end
