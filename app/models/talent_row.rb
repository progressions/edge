# == Schema Information
#
# Table name: talent_rows
#
#  id                :integer          not null, primary key
#  specialization_id :integer
#  cost              :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class TalentRow < ActiveRecord::Base
  belongs_to :specialization
end
