# == Schema Information
#
# Table name: talent_boxes
#
#  id            :integer          not null, primary key
#  talent_row_id :integer
#  key           :string(255)
#  position      :integer
#  left          :boolean
#  right         :boolean
#  up            :boolean
#  down          :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class TalentBox < ActiveRecord::Base
  belongs_to :talent_row

  delegate :name, to: :talent

  def talent
    Talent.lookup(key)
  end

  def self.unique_key?
    false
  end
end
