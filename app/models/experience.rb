# == Schema Information
#
# Table name: experiences
#
#  id           :integer          not null, primary key
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Experience < ActiveRecord::Base
  belongs_to :character
end
